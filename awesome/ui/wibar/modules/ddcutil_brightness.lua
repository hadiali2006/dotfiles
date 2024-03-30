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

local theme = beautiful.modules.ddcutil

local BRIGHTNESS_ICON     = theme.icon.brightness

local bg_color_markup     = theme.widget.markup.background
local fg_color_markup     = theme.widget.markup.foreground

local bg_color_widget     = theme.widget.background_container.background
local fg_color_widget     = theme.widget.background_container.foreground
local border_color_widget = theme.widget.background_container.border_color
local border_width_widget = theme.widget.background_container.border_width

local internal_svg_imagebox = {
    widget = wibox.widget.imagebox(),
    image = theme.icon.brightness_svg,
    resize = true,
    valign = "center",
    halign = "center",
    forced_width  = 16,
}

local internal_icon_textbox = {
    widget = wibox.widget.textbox(),
    markup = string.format(
        "<span color='%s' bgcolor='%s'>%s</span>",
        fg_color_markup, bg_color_markup, BRIGHTNESS_ICON)
}

local internal_brightness_textbox = {
    widget = wibox.widget.textbox(),
}

local container_widget_table = {
    {
        {
            {
                wibox.widget.textbox(" "),
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                internal_svg_imagebox,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                wibox.widget.textbox(beautiful.thin_space),
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                internal_brightness_textbox,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget       = wibox.container.background,
        border_color = border_color_widget,
        border_width = border_width_widget,
    },
    widget = wibox.container.margin,
    margins = {
        top    = 5,
        bottom = 5,
        right  = 5,
        left   = 5,
    },
}

local ddcutil_brightness_widget = internal_brightness_textbox.widget
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

local function set_ddcutil_brightness_content(new_content)
    ddcutil_brightness_widget:set_markup_silently(string.format(
        "<span color='%s' bgcolor='%s'>%s%% </span>",
        fg_color_markup, bg_color_markup, new_content))
end

awesome.connect_signal("ddcutil::brightness::set::current", function ()
    get_brightness_from_ddcutil(function(current_brightness)
        set_ddcutil_brightness_content(current_brightness)
    end)
end)

awesome.connect_signal("ddcutil::brightness::set::new", function (new_brightness)
        set_ddcutil_brightness_content(new_brightness)
end)

return function ()
    ddcutil_brightness_widget:set_markup_silently(string.format(
        "<span color='%s' bgcolor='%s'>%s </span>",
        fg_color_markup, bg_color_markup, "n/a"))
    return full_ddcutil_brightness_widget
end
