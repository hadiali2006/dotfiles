local require = require
local capi = { client = client }
local awful = require("awful")
local mod = require("binds.mod")

return {
    awful.key({ mod.super }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ mod.super }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ mod.super }, "Tab",
        function()
            awful.client.focus.history.previous()
            if capi.client.focus then
                capi.client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }
    ),
    awful.key({ mod.super, mod.ctrl }, "j",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "focus the next screen", group = "screen" }
    ),
    awful.key({ mod.super, mod.ctrl }, "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        { description = "focus the previous screen", group = "screen" }
    ),
    awful.key({ mod.super, mod.ctrl }, "n",
        function()
            local client = awful.client.restore()
            if client then
                client:activate({ raise = true, context = "key.unminimize" })
            end
        end,
        { description = "restore minimized", group = "client" }
    ),
}
