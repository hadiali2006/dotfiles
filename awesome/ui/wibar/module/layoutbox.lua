local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local function internal_layoutbox(screen)
    return awful.widget.layoutbox({
        screen = screen,
        buttons = {
            awful.button(nil, 1, function()
                awful.layout.inc(1)
            end),
            awful.button(nil, 3, function()
                awful.layout.inc(-1)
            end),
            awful.button(nil, 4, function()
                awful.layout.inc(-1)
            end),
            awful.button(nil, 5, function()
                awful.layout.inc(1)
            end),
        },
    })
end

return function(screen)
    return wibox.widget({
        {
            {
                internal_layoutbox(screen),
                widget = wibox.container.margin,
                margins = {
                    left = 2.5,
                    right = 2.5,
                    bottom = 2.5,
                    top = 2.5,
                },
            },
            widget = wibox.container.background,
            bg = beautiful.wibar_widget_bg,
            fg = beautiful.wibar_widget_fg,
            border_color = beautiful.wibar_widget_border_color,
            border_width = beautiful.wibar_widget_border_width,
        },
        margins = {
            top = beautiful.wibar_widget_margin,
            bottom = beautiful.wibar_widget_margin,
            right = beautiful.wibar_widget_margin,
            left = beautiful.wibar_widget_margin,
        },
        widget = wibox.container.margin,
    })
end
