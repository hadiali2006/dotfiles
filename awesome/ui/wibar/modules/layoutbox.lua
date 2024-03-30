local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi
local theme = beautiful.modules.layoutbox

local function internal_layoutbox(s)
    return awful.widget.layoutbox({
        screen = s,
        buttons = {
            awful.button(nil, 1, function() awful.layout.inc(1) end),
            awful.button(nil, 3, function() awful.layout.inc(-1) end),
            awful.button(nil, 4, function() awful.layout.inc(-1) end),
            awful.button(nil, 5, function() awful.layout.inc(1) end)
        }
    })
end

return function(s)
    return wibox.widget({
        {
            {
                internal_layoutbox(s),
                widget = wibox.container.margin,
                margins = {
                    left   = 2.5,
                    right  = 2.5,
                    bottom = 2.5,
                    top    = 2.5,
                },
            },
            widget       = wibox.container.background,
            bg           = theme.background,
            fg           = theme.foreground,
            border_color = theme.border_color,
            border_width = theme.border_width,
        },
        margins = {
            left   = 5,
            right  = 5,
            bottom = 5,
            top    = 5,
        },
        widget = wibox.container.margin
    })
end
