local require = require
local awful = require("awful")
local capi = { tag = tag }
capi.tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts(require("config.user").layouts)
end)
