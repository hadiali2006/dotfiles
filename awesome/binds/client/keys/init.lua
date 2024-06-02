local pairs, require = pairs, require
local awful = require("awful")
local capi = { client = client }

local bindings = {
    require(... .. ".general"),
    require(... .. ".scratchpad"),
}
capi.client.connect_signal("request::default_keybindings", function()
    for _, v in pairs(bindings) do
        awful.keyboard.append_client_keybindings(v)
    end
end)
