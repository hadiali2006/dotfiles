local naughty = require("naughty")

-- Function to create and show a notification
local function notif(title, message)
    naughty.notify({
        title = title,
        text = message,
        timeout = 10,  -- Timeout in seconds
        position = "top_right"  -- Position of the notification
    })
end

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local brightness_icon     = " 󰛩 "

local bg_color_markup     = beautiful.widget.bg_markup
local fg_color_markup     = beautiful.widget.fg_markup

local bg_color_widget     = beautiful.widget.bg_widget
local fg_color_widget     = beautiful.widget.fg_widget
local border_color_widget = beautiful.widget.border_widget
local border_width_widget = beautiful.widget.border_size

local internal_textbox = {
    widget = wibox.widget.textbox(),
}

local container_widget_table = {
    internal_textbox,
    widget       = wibox.container.background,
    bg           = bg_color_widget,
    fg           = fg_color_widget,
    border_width = border_width_widget,
    border_color = border_color_widget,
}

local ddcutil_brightness_widget = internal_textbox.widget
local full_ddcutil_brightness_widget = wibox.widget(container_widget_table)

ddcutil_brightness_widget.buttons = {
    awful.button(nil, 1, function ()
        awesome.emit_signal("prompt::ddcutil::brightness")
    end)
}

local ddcutil_cmd = {
    set_brightness = "ddcutil setvcp 10",
    get_brightness = "ddcutil getvcp 10",
}

local function get_brightness_from_ddcutil(callback)
    awful.spawn.easy_async(ddcutil_cmd.get_brightness, function (stdout)
        local current_brightness = stdout:match("current value =%s+(%d+)")
        callback(current_brightness)
    end)
end

awesome.connect_signal("ddcutil::brightness::set::current", function ()
    get_brightness_from_ddcutil(function (brightness)
        ddcutil_brightness_widget:set_markup_silently(string.format(
            "<span color='%s' bgcolor='%s'>%s%s </span>",
            fg_color_markup, bg_color_markup, brightness_icon, brightness))
    end)
end)

awesome.connect_signal("ddcutil::brightness::set::new", function (new_brightness)
    ddcutil_brightness_widget:set_markup_silently(string.format(
        "<span color='%s' bgcolor='%s'>%s%s </span>",
        fg_color_markup, bg_color_markup, brightness_icon, new_brightness))
end)

return function ()
    return full_ddcutil_brightness_widget
end
