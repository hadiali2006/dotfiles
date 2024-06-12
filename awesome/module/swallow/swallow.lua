---@meta
---@module "swallow"

local require = require
local tostring = tostring
local pairs = pairs
local string = string
local table = table

local capi = { client = client, }

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

-- It might actually swallow too much, that's why there is a filter option by classname
-- without the don't-swallow-list it would also swallow for example
-- file pickers or new firefox windows spawned by an already existing one

local window_swallowing_activated = false

-- you might want to add or remove applications here
local parent_filter_list = beautiful.parent_filter_list
    or beautiful.dont_swallow_classname_list
    or { "firefox", "Gimp", "Google-chrome" }
local child_filter_list = beautiful.child_filter_list
    or beautiful.dont_swallow_classname_list or { }

-- for boolean values the or chain way to set the values breaks with 2 vars
-- and always defaults to true so i had to do this to se the right value...
local swallowing_filter = true
local filter_vars = { beautiful.swallowing_filter, beautiful.dont_swallow_filter_activated }
for _, var in pairs(filter_vars) do
    swallowing_filter = var
end

local util = {}

-- check if element exist in table
-- returns true if it is
---@param element any
---@param source table
util.is_in_table = function(element, source)
    local res = false
    for _, value in pairs(table) do
        if element:match(value) then
            res = true
            break
        end
    end
    return res
end


---@param client client
---@param current_tag tag
util.turn_on = function(client, current_tag)
    if not current_tag and client.screen.selected_tag then
        current_tag = client.screen.selected_tag
    end
    local client_tags = {}
    for _, tag in pairs(client:tags()) do
        if tag ~= current_tag then
            table.insert(client_tags, tag)
        end
    end
    client:tags(client_tags)
    client.sticky = false
end

---@param client client
util.turn_off = function(client)
    local current_tag
    if client.screen.selected_tag then
        current_tag = client.screen.selected_tag
    end
    local client_tags = { current_tag }
    for _, tag in pairs(client:tags()) do
        if tag ~= current_tag then
            table.insert(client_tags, tag)
        end
    end
    client:tags(client_tags)
    client:activate({})
end

---@param target_client client
---@param source_client client
util.sync = function(target_client, source_client)
    if not source_client or not target_client then
        return
    end
    if not source_client.valid or not target_client.valid then
        return
    end
    if source_client.modal then
        return
    end
    target_client.floating = source_client.floating
    target_client.maximized = source_client.maximized
    target_client.above = source_client.above
    target_client.below = source_client.below
    target_client:geometry(source_client:geometry())
    -- TODO: Should also copy over the position in a tiling layout
end

-- if the swallowing filter is active checks the child and parent classes
-- against their filters
util.check_swallow = function(parent, child)
    local res = true
    if swallowing_filter then
        local prnt = not util.is_in_table(parent, parent_filter_list)
        local chld = not util.is_in_table(child, child_filter_list)
        res = (prnt and chld)
    end
    return res
end

util.get_parent_pid = function(child_ppid, callback)
    local ppid_cmd = string.format("pstree -A -p -s %s", child_ppid)
    awful.spawn.easy_async(ppid_cmd, function(stdout, stderr)
        -- primitive error checking
        if stderr and stderr ~= "" then
            callback(stderr)
            return
        end
        local ppid = stdout
        callback(nil, ppid)
    end)
end

---@param client client
util.manage_client_spawn = function(client)
    -- get the last focused window to check if it is a parent window
    local parent_client = awful.client.focus.history.get(client.screen, 1)
    if not parent_client then
        return
    elseif parent_client.type == "dialog" or parent_client.type == "splash" then
        return
    end
    util.get_parent_pid(client.pid, function(err, ppid)
        if err then
            return
        end
        local parent_pid = ppid
    if
        -- will search for "(parent_client.pid)" inside the parent_pid string
        (tostring(parent_pid):find("("..tostring(parent_client.pid)..")"))
        and util.check_swallow(parent_client.class, client.class)
    then
        client:connect_signal("request::unmanage", function()
            if parent_client then
                util.client.turn_on(parent_client)
                util.client.sync(parent_client, client)
            end
        end)
        util.client.sync(client, parent_client)
        util.client.turn_off(parent_client)
    end
    end)
end

local swallow = {}

swallow.start = function()
    capi.client.disconnect_signal(
        "request::manage",
        util.manage_client_spawn
    )
    window_swallowing_activated = true
end

swallow.stop = function()
    capi.client.disconnect_signal(
        "request::manage",
        util.manage_client_spawn
    )
    window_swallowing_activated = false
end

swallow.toggle = function()
    if window_swallowing_activated then
        swallow.stop()
    else
        swallow.start()
    end
end

return swallow
