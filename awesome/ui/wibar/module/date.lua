local require = require
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
-- local popup = require("ui.popups.calendar")

local DATE_FORMAT = "%a %B %d"

local icon_widget = wibox.widget.imagebox()

local textclock_widget = {
    format = DATE_FORMAT,
    widget = wibox.widget.textclock,
}

local time_widget = wibox.widget({
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
})

time_widget.buttons = {
    awful.button(nil, 1,
        function()
            -- awful.placement.top_right(
            --     popup,
            --     {
            --         honor_workarea = true,
            --         margins = { right = 6, bottom = 6 }
            --     }
            -- )
            -- popup.visible = not popup.visible
        end
    ),
}


return function()
    icon_widget:set_image(beautiful.date_icon)
    return time_widget
end
