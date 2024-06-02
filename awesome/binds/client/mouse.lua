local awful = require("awful")
local mod = require("binds.mod")
local capi = { client = client }

local binds = {
    awful.button({}, 1,
        function(client)
            client:activate({
                context = "mouse_click"
            })
        end
    ),
    awful.button({ mod.super, }, 1,
        function(client)
            client:activate({
                context = "mouse_click",
                action = "mouse_move"
            })
        end
    ),
    awful.button({ mod.super }, 3,
        function(client)
            client:activate({
                context = "mouse_click",
                action = "mouse_resize"
            })
        end
    ),
}
capi.client.connect_signal("request::default_mousebindings", function()
   awful.mouse.append_client_mousebindings(binds)
end)
