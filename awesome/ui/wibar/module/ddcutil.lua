local require = require
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local text_widget = wibox.widget.textbox("n/a")
local icon_widget = wibox.widget.imagebox()

local brightness_widget = wibox.widget({
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
            text_widget,
            wibox.widget.textbox(" "),
        },
    }
})

local ddcutil_cmd = {
    set_brightness = "ddcutil setvcp 10",
    get_brightness = "ddcutil getvcp 10",
}

local function get_brightness_from_ddcutil(callback)
    awful.spawn.easy_async(
        ddcutil_cmd.get_brightness,
        function(stdout)
            local current_brightness = stdout:match("current value =%s+(%d+)")
            callback(current_brightness)
        end
    )
end

local signal_callbacks = {
    set_current = function(_)
        get_brightness_from_ddcutil(
            function(current_brightness)
                text_widget:set_markup_silently(current_brightness .. "%")
            end
        )
    end,
    set_new = function(_, new_brightness)
        text_widget:set_markup_silently(new_brightness .. "%")
    end,
}

do
    brightness_widget:connect_signal("set::current", signal_callbacks.set_current)
    brightness_widget:connect_signal("set::new", signal_callbacks.set_new)
end

return function()
    icon_widget:set_image(beautiful.brightness_icon)
    return brightness_widget
end
