local require = require
local awful = require("awful")
local mod = require("binds.mod")
return {

    awful.key({ mod.super, mod.shift }, "t",
        awful.titlebar.toggle,
        { description = "toggle titlebar", group = "client" }
    ),
    awful.key({ mod.super, mod.shift }, "f",
        function(client)
            client.fullscreen = not client.fullscreen
            client:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),
    awful.key({ mod.super, }, "q",
        function(client)
            client:kill()
        end,
        { description = "close", group = "client" }
    ),
    awful.key({ mod.super, mod.ctrl }, "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key({ mod.super, mod.ctrl }, "t",
        function(client)
            client.ontop = not client.ontop
        end,
        { description = "toggle keep on top", group = "client" }
    ),
    awful.key({ mod.super, mod.ctrl }, "s",
        function(client)
            client.sticky = not client.sticky
        end,
        { description = "toggle sticky", group = "client" }
    ),
    awful.key({ mod.super, }, "m",
        function(client)
            client.maximized = not client.maximized
            client:raise()
        end,
        { description = "(un)maximize", group = "client" }
    ),
    awful.key({ mod.super, mod.ctrl }, "m",
        function(client)
            client.maximized_vertical = not client.maximized_vertical
            client:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }
    ),
    awful.key({ mod.super, mod.shift }, "m",
        function(client)
            client.maximized_horizontal = not client.maximized_horizontal
            client:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" }
    ),
    awful.key({ mod.super, }, "n",
        function(client)
            client.minimized = true
        end,
        { description = "minimize", group = "client" }
    ),
    awful.key({ mod.super, mod.ctrl }, "Return",
        function(client)
            client:swap(awful.client.getmaster())
        end,
        { description = "move to master", group = "client" }
    ),
    awful.key({ mod.super, mod.shift }, "z",
        function(client)
            client:move_to_screen()
        end,
        { description = "move to screen", group = "client" }
    ),
}
