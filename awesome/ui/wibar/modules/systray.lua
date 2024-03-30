local wibox     = require("wibox")
local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")

local theme = beautiful.modules.systray
local dpi = beautiful.xresources.apply_dpi

local SYSTRAY_ICON       = theme.icon.menu_svg

local bg_color_markup     = theme.widget.markup.background
local fg_color_markup     = theme.widget.markup.foreground

local bg_color_widget     = theme.widget.background_container.background
local fg_color_widget     = theme.widget.background_container.foreground
local border_color_widget = theme.widget.background_container.border_color
local border_width_widget = theme.widget.background_container.border_width

local border_color_popup  = theme.popup.border_color
local border_width_popup  = theme.popup.border_width

local internal_icon_imagebox = {
    widget = wibox.widget.imagebox(),
    image = SYSTRAY_ICON,
}

local internal_systray = {
    widget = wibox.widget.systray(),
}

local container_widget_table = {
    {
        internal_icon_imagebox,
        widget       = wibox.container.background,
        bg           = bg_color_widget,
        fg           = fg_color_widget,
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

local btn_widget = internal_icon_imagebox.widget
local systray_widget = internal_systray.widget
local full_systray_widget = wibox.widget(container_widget_table)

local pop_tray = awful.popup {
    widget = {
        internal_systray,
        widget = wibox.container.margin,
        margins = {
            top    = 5,
            bottom = 5,
            right  = 5,
            left   = 5,
        },
    },
    hide_on_right_click = true,
    border_color = border_color_popup,
    border_width = border_width_popup,
    ontop = true,
    visible = false,
    x = 10,
    y = 33 + 5,
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
