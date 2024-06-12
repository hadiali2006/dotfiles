local require = require
local string = string
local tostring = tostring
local setmetatable = setmetatable
local capi = { client = client, }
local awful = require("awful")

---@module "module.swallow.swallow.util"
local util = require(... .. ".util")

---@class swallow
---@field parent_filter_list table #
---@field child_filter_list table #
---@field window_swallow_active boolean #
---@field swallowing_filter boolean #
local swallow = {}

function swallow:new(args)
    local object = setmetatable({}, self)
    self.__index = self
    object.parent_filter_list = args.parent_filter_list
        or args.dont_swallow_classname_list
        or { "firefox", "Gimp", "Google-chrome", }
    object.child_filter_list = args.child_filter_list
        or args.dont_swallow_classname_list
        or {}
    object.window_swallow_active = false
    object.swallowing_filter = true
    for _, var in pairs({ args.swallowing_filter, args.dont_swallow_filter_activated, }) do
        object.swallowing_filter = var
    end
    return object
end

-- if the swallowing filter is active checks the child and parent classes against their filters
---@param parent any
---@param child any
---@return any
function swallow:check_swallow(parent, child)
    local res = true
    if self.swallowing_filter then
        local prnt = not util.is_in_table(parent, self.parent_filter_list)
        local chld = not util.is_in_table(child, self.child_filter_list)
        res = (prnt and chld)
    end
    return res
end

---@param child_ppid any
---@param callback fun(stderr: string?, ppid: string?)
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
local manage_client_spawn = function(client)
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

function swallow:start()
    capi.client.disconnect_signal(
        "request::manage",
        util.manage_client_spawn
    )
    self.window_swallowing_activated = true
end

function swallow:stop()
    capi.client.disconnect_signal(
        "request::manage",
        util.manage_client_spawn
    )
    self.window_swallowing_activated = false
end

function swallow:toggle()
    if self.window_swallowing_activated then
        self:stop()
    else
        self:start()
    end
end
