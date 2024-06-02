local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local helpers = {
    client = {
         --- Turn off passed client
         -- Remove current tag from window's tags
         --
         ---@param c client
        turn_off = function(c, current_tag)
            if current_tag == nil then
                current_tag = c.screen.selected_tag
            end
            local ctags = {}
            for _, tag in pairs(c:tags()) do
                if tag ~= current_tag then
                    table.insert(ctags, tag)
                end
            end
            c:tags(ctags)
            c.sticky = false
        end,

        --- Turn on passed client (add current tag to window's tags)
        --
        ---@param c client
        turn_on = function(c)
            local current_tag = c.screen.selected_tag
            local ctags = { current_tag }
            for _, tag in pairs(c:tags()) do
                if tag ~= current_tag then
                    table.insert(ctags, tag)
                end
            end
            c:tags(ctags)
            c:raise()
            client.focus = c
        end,

        --- Sync two clients
        --
        ---@param to_c client The client to which to write all properties
        ---@param from_c client The client from which to read all properties
        sync = function(to_c, from_c)
            if not from_c or not to_c then
                return
            end
            if not from_c.valid or not to_c.valid then
                return
            end
            if from_c.modal then
                return
            end
            to_c.floating = from_c.floating
            to_c.maximized = from_c.maximized
            to_c.above = from_c.above
            to_c.below = from_c.below
            to_c:geometry(from_c:geometry())
            -- TODO: Should also copy over the position in a tiling layout
        end,

        --- Checks whether the passed client is a childprocess of a given process ID
        --
        ---@param c client
        ---@param pid string # The process ID
        ---@return (boolean|string)? # True if the passed client is a childprocess of the given PID otherwise false
        is_child_of = function(c, pid)
            -- io.popen is normally discouraged. Should probably be changed
            if not c or not c.valid then
                return false
            end
            if tostring(c.pid) == tostring(pid) then
                return true
            end
            local pid_cmd = [[pstree -T -p -a -s ]]
            .. tostring(c.pid)
            .. [[ | sed '2q;d' | grep -o '[0-9]*$' | tr -d '\n']]
            local handle = io.popen(pid_cmd)
            if handle then
                local parent_pid = handle:read("*a")
                handle:close()
                return tostring(parent_pid) == tostring(pid)
                    or tostring(parent_pid) == tostring(c.pid)
            else
                return nil
            end
        end,

        ---Finds all clients that satisfy the passed rule
        ---@param rule table The rule to be searched for
        ---@return table: A list of clients that match the given rule
        find = function(rule)
            local function matcher(c)
                return awful.rules.match(c, rule)
            end
            local clients = client.get()
            local findex = gears.table.hasitem(clients, client.focus) or 1
            local start = gears.math.cycle(#clients, findex + 1)

            local matches = {}
            for c in awful.client.iterate(matcher, start) do
                matches[#matches + 1] = c
            end

            return matches
        end,

        ---Gets the next client by direction from the focused one
        ---@param direction string: the direction as a string ("up", "down", "left" or "right")
        ---@return client?: The client in the given direction starting at the currently focused one, nil otherwise
        get_by_direction = function(direction)
            local sel = client.focus
            if not sel then
                return nil
            end
            local cltbl = sel.screen:get_clients()
            local geomtbl = {}
            for i, cl in ipairs(cltbl) do
                geomtbl[i] = cl:geometry()
            end
            local target = gears.geometry.rectangle.get_in_direction(
                direction,
                geomtbl,
                sel:geometry()
            )
            return cltbl[target]
        end,
    }
}

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

-- check if element exist in table
-- returns true if it is
local function is_in_table(element, table)
    local res = false
    for _, value in pairs(table) do
        if element:match(value) then
            res = true
            break
        end
    end
    return res
end

-- if the swallowing filter is active checks the child and parent classes
-- against their filters
local function check_swallow(parent, child)
    local res = true
    if swallowing_filter then
        local prnt = not is_in_table(parent, parent_filter_list)
        local chld = not is_in_table(child, child_filter_list)
        res = (prnt and chld)
    end
    return res
end

-- async function to get the parent's pid
-- recieves a child process pid and a callback function
-- parent_pid in format "init(1)---ancestorA(pidA)---ancestorB(pidB)...---process(pid)"
local function get_parent_pid(child_ppid, callback)
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


-- the function that will be connected to / disconnected from the spawn client signal
local function manage_clientspawn(c)
    -- get the last focused window to check if it is a parent window
    local parent_client = awful.client.focus.history.get(c.screen, 1)
    if not parent_client then
        return
    elseif parent_client.type == "dialog" or parent_client.type == "splash" then
        return
    end
    get_parent_pid(c.pid, function(err, ppid)
        if err then
            return
        end
        local parent_pid = ppid
    if
        -- will search for "(parent_client.pid)" inside the parent_pid string
        (tostring(parent_pid):find("("..tostring(parent_client.pid)..")"))
        and check_swallow(parent_client.class, c.class)
    then
        c:connect_signal("unmanage", function()
            if parent_client then
                helpers.client.turn_on(parent_client)
                helpers.client.sync(parent_client, c)
            end
        end)

        helpers.client.sync(c, parent_client)
        helpers.client.turn_off(parent_client)
    end
    end)
end

-- without the following functions that module would be autoloaded by require("bling")
-- a toggle window swallowing hotkey is also possible that way

local function start()
    client.connect_signal("request::manage", manage_clientspawn)
    window_swallowing_activated = true
end

local function stop()
    client.disconnect_signal("request::manage", manage_clientspawn)
    window_swallowing_activated = false
end

local function toggle()
    if window_swallowing_activated then
        stop()
    else
        start()
    end
end

return {
    start = start,
    stop = stop,
    toggle = toggle,
}
