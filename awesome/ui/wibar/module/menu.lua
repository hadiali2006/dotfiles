local require = require
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local image_widget = wibox.widget.imagebox()
local systray_widget = wibox.widget({
    {
        {
            wibox.widget.systray,
            widget = wibox.container.margin,
            margins = {
                top = 3,
                bottom = 3,
                right = 3,
                left = 3,
            },
        },
        widget = wibox.container.background,
        bg = beautiful.wibar_widget_bg,
        fg = beautiful.wibar_widget_fg,
        border_color = beautiful.wibar_widget_border_color,
        border_width = beautiful.wibar_widget_border_width,
    },
    widget = wibox.container.margin,
    margins = {
        top = 4,
        bottom = 4,
        right = 4,
        left = 4,
    },
})

local menu_widget = wibox.widget({
    {
        {
            image_widget,
            widget = wibox.container.background,
            bg = beautiful.wibar_widget_bg,
            fg = beautiful.wibar_widget_fg,
            border_color = beautiful.wibar_widget_border_color,
            border_width = beautiful.wibar_widget_border_width,
        },
        widget = wibox.container.margin,
        top = beautiful.wibar_widget_margin,
        bottom = beautiful.wibar_widget_margin,
        right = beautiful.wibar_widget_margin,
        left = beautiful.wibar_widget_margin,
    },
    systray_widget,
    layout = wibox.layout.fixed.horizontal,
})

menu_widget.buttons = {
    awful.button({}, 1, function()
        systray_widget.visible = not systray_widget.visible
    end),
}

return function()
    systray_widget.visible = false
    image_widget:set_image(beautiful.menu_icon)
    return menu_widget
end
