local require = require
local beautiful = require("beautiful")
local wibox = require("wibox")
local CLOCK_UPDATE_RATE_IN_SECONDS = 1
local CLOCK_FORMAT = "%I:%M:%S %p"

local icon_widget = wibox.widget.imagebox()
local textclock_widget = {
    widget = wibox.widget.textclock,
    refresh = CLOCK_UPDATE_RATE_IN_SECONDS,
    format = CLOCK_FORMAT
}

local time_widget = {
    widget = wibox.container.margin,
    margins = {
        top    = beautiful.wibar_widget_margin,
        bottom = beautiful.wibar_widget_margin,
        right  = beautiful.wibar_widget_margin,
        left   = beautiful.wibar_widget_margin,
    },
    {
        widget = wibox.container.background,
        bg = beautiful.wibar_widget_bg,
        fg = beautiful.wibar_widget_fg,
        border_color = beautiful.wibar_widget_border_color,
        border_width = beautiful.wibar_widget_border_width,
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.textbox(" "),
            icon_widget,
            textclock_widget,
            wibox.widget.textbox(" "),
        },
    }
}
return function()
    icon_widget:set_image(beautiful.time_icon)
    return time_widget
end
