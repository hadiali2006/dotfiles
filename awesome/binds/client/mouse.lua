local awful  = require("awful")

local mod    = require("binds.mod")
local modkey = mod.modkey

--- Client mouse bindings.
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button(nil, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        awful.button({ modkey }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        awful.button({ modkey }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end)
    })
end)
-- vim: ts=4 sts=4 sw=4 et
