local wibox     = require("wibox")
local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

local SYSTRAY_ICON       = " 󰗘 "

local bg_color_markup     = beautiful.widget.bg_markup
local fg_color_markup     = beautiful.widget.fg_markup

local bg_color_widget     = beautiful.widget.bg_widget
local fg_color_widget     = beautiful.widget.fg_widget
local border_color_widget = beautiful.widget.border_widget
local border_width_widget = beautiful.widget.border_size

local border_color_popup = beautiful.widget.border_popup

local internal_textbox = {
    widget = wibox.widget.textbox(),
    markup = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s</span>",
        fg_color_markup, bg_color_markup, SYSTRAY_ICON),
}

local internal_systray = {
    widget = wibox.widget.systray(),
}

local container_widget_table = {
    internal_textbox,
    widget       = wibox.container.background,
    bg           = bg_color_widget,
    fg           = fg_color_widget,
    border_width = border_width_widget,
    border_color = border_color_widget,
}


local btn_widget = internal_textbox.widget
local systray_widget = internal_systray.widget
local full_systray_widget = wibox.widget(container_widget_table)

local pop_tray = awful.popup {
    widget = systray_widget,
    hide_on_right_click = true,
    border_color = border_color_popup,
    border_width = 5,
    visible = false,
    ontop = true,
    x = 10 + 5,
    y = 33 + 15,
}

btn_widget.buttons = {
    awful.button({}, 1, function()
        pop_tray.visible = not pop_tray.visible
    end),
}

return function ()
    systray_widget:set_base_size(24)
    return full_systray_widget
end
