local awful       = require("awful")
local scratchpads = require("config.scratchpads")
local mod         = require("binds.mod")
local modkey      = mod.modkey

local is_floating = function(client)
    return
        client.floatinig or
        client.screen.selected_tag.layout.name == "floating"
end

awful.key.keygroups.hjkl = {
    { "h", "H"},
    { "j", "J"},
    { "k", "K"},
    { "l", "L"},
}
awful.key.keygroup.HJKL = "hjkl"
local client_state_binds = {
    awful.key(
        { modkey, mod.alt },
        "F1",
        function (c)
            scratchpads.F1_pad:toggle_scratched_status(c)
        end
    ),
    awful.key(
        { modkey, mod.alt },
        "F2",
        function (c)
            scratchpads.F2_pad:toggle_scratched_status(c)
        end
    ),
    awful.key(
        { modkey, mod.alt },
        "F3",
        function (c)
            scratchpads.F3_pad:toggle_scratched_status(c)
        end
    ),
    awful.key(
        { modkey, mod.alt },
        "F4",
        function (c)
            scratchpads.F4_pad:toggle_scratched_status(c)
        end
    ),
    awful.key(
        { modkey, mod.shift },
        "t",
        awful.titlebar.toggle,
        {
            description = "toggle titlebar",
            group = "client"
        }
    ),
    awful.key(
        { modkey },
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {
            description = "toggle fullscreen",
            group = "client"
        }
    ),
    awful.key(
        { modkey },
        "q",
        function(c)
            c:kill()
        end,
        {
            description = "close",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl },
        "space",
        awful.client.floating.toggle,
        {
            description = "toggle floating",
            group = "client"
        }
    ),
    awful.key(
        { modkey },
        "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {
            description = "minimize",
            group = "client"
        }
    ),
    awful.key(
        { modkey },
        "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {
            description = "(un)maximize",
            group = "client" }
    ),
    awful.key(
        { modkey, mod.ctrl },
        "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {
            description = "(un)maximize vertically",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.shift },
        "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {
            description = "(un)maximize horizontally",
            group = "client"
        }
    ),
}

local client_tiling_window_binds = {
    awful.key(
        { modkey, mod.ctrl },
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {
            description = "move to master",
            group = "client"
        }
    ),
    awful.key(
        { modkey },
        "o",
        function(c)
            c:move_to_screen()
        end,
        {
            description = "move to screen",
            group = "client"
        }
    ),
    awful.key(
        { modkey },
        "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {
            description = "toggle keep on top",
            group = "client"
        }
    ),
}

local client_resize_increase = {
    awful.key(
        { modkey, mod.ctrl },
        "Up",
        function(c)
            if is_floating(c) then
                c:relative_move(0, -10, 0, 10)
            else
                awful.client.incwfact(0.025)
            end
        end,
        {
            description = "increase upper portion",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl },
        "Down",
        function(c)
            if  is_floating(c) then
                c:relative_move(0, 0, 0, 10)
            else
                awful.client.incwfact(-0.025)
            end
        end,
        {
            description = "increase lower portion",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl },
        "Left",
        function(c)
            if is_floating(c) then
                c:relative_move(-10, 0, 10, 0)
            else
                awful.tag.incmwfact(-0.025)
            end
        end,
        {
            description = "increase left portion",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl },
        "Right",
        function(c)
            if is_floating(c) then
                c:relative_move(0, 0, 10, 0)
            else
                awful.tag.incmwfact(0.025)
            end
        end,
        {
            description = "increase right portion",
            group = "client"
        }
    ),
}
local client_resize_decrease = {
    awful.key(
        { modkey, mod.ctrl, mod.shift },
        "Up",
        function(c)
            if is_floating(c) then
                c:relative_move(0, 10, 0, -10)
            else
                awful.client.incwfact(0.025)
            end
        end,
        {
            description = "decrease upper portion",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl, mod.shift },
        "Down",
        function(c)
            if  is_floating(c) then
                c:relative_move(0, 0, 0, -10)
            else
                awful.client.incwfact(-0.025)
            end
        end,
        {
            description = "increase lower portion",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl, mod.shift },
        "Left",
        function(c)
            if is_floating(c) then
                c:relative_move(10, 0, -10, 0)
            else
                awful.tag.incmwfact(-0.025)
            end
        end,
        {
            description = "increase left portion",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.ctrl, mod.shift },
        "Right",
        function(c)
            if is_floating(c) then
                c:relative_move(0, 0, -10, 0)
            else
                awful.tag.incmwfact(0.025)
            end
        end,
        {
            description = "increase right portion",
            group = "client"
        }
    ),
}

local client_move_floating = {
    awful.key(
        { modkey, mod.alt },
        "Down",
        function(c)
            c:relative_move(0, 10, 0, 0)
        end,
        {
            description = "Floating Move Down",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.alt },
        "Up",
        function(c)
            c:relative_move(0, -10, 0, 0)
        end,
        {
            description = "Floating Move Up",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.alt },
        "Left",
        function(c)
            c:relative_move(-10, 0, 0, 0)
        end,
        {
            description = "Floating Move Left",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.alt },
        "Right",
        function(c)
            c:relative_move(10, 0, 0, 0)
        end,
        {
            description = "Floating Move Right",
            group = "client"
        }
    ),
}

local client_focus = {
    awful.key(
        { modkey, mod.alt },
        "j",
        function(c)
            awful.client.focus.global_bydirection("down")
            c:lower()
        end,
        {
            description = "focus next window up",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.alt },
        "k",
        function(c)
            awful.client.focus.global_bydirection("up")
            c:lower()
        end,
        {
            description = "focus next window down",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.alt },
        "l",
        function(c)
            awful.client.focus.global_bydirection("right")
            c:lower()
        end,
        {
            description = "focus next window right",
            group = "client"
        }
    ),
    awful.key(
        { modkey, mod.alt },
        "h",
        function(c)
            awful.client.focus.global_bydirection("left")
            c:lower()
        end,
        {
            description = "focus next window left",
            group = "client"
        }
    ),
}

--  NOTE: below is for multi-monitor probably, i'll keep it here for now.
--
-- local client_swap_between_desktop = {
--     awful.key(
--         { modkey, mod.alt, mod.ctrl },
--         "h",
--         function(c)
--             awful.client.swap.global_bydirection("left")
--             c:raise()
--         end,
--         {
--             description = "swap with left client",
--             group = "client"
--         }
--     ),
--     awful.key(
--         { modkey, mod.alt, mod.ctrl },
--         "l",
--         function(c)
--             awful.client.swap.global_bydirection("right")
--             c:raise()
--         end,
--         {
--             description = "swap with right client",
--             group = "client"
--         }
--     ),
--     awful.key(
--         { modkey, mod.alt, mod.ctrl },
--         "j",
--         function(c)
--             awful.client.swap.global_bydirection("down")
--             c:raise()
--         end,
--         {
--             description = "swap with down client",
--             group = "client" }
--     ),
--     awful.key(
--         { modkey, mod.alt, mod.ctrl },
--         "k",
--         function(c)
--             awful.client.swap.global_bydirection("up")
--             c:raise()
--         end,
--         {
--             description = "swap with up client",
--             group = "client"
--         }
--     ),
-- }
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings(client_state_binds)
    awful.keyboard.append_client_keybindings(client_tiling_window_binds)
    awful.keyboard.append_client_keybindings(client_resize_increase)
    awful.keyboard.append_client_keybindings(client_resize_decrease)
    awful.keyboard.append_client_keybindings(client_move_floating)
    awful.keyboard.append_client_keybindings(client_focus)
end)
