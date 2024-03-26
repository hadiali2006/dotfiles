local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

local CLOCK_ICON                = "  "
local CLOCK_UPDATE_RATE_SECONDS = 1
local CLOCK_FORMAT              = "%I:%M:%S %p"

local bg_color_markup     = beautiful.widget.bg_markup
local fg_color_markup     = beautiful.widget.fg_markup

local bg_color_widget     = beautiful.widget.bg_widget
local fg_color_widget     = beautiful.widget.fg_widget
local border_color_widget = beautiful.widget.border_widget
local border_width_widget = beautiful.widget.border_size

local internal_textclock = {
    widget = wibox.widget.textclock,
    refresh = CLOCK_UPDATE_RATE_SECONDS,
    -- format = string.format(
    --     "<span background='%s' foreground='%s'>%s%s </span>",
    --     bg_color_markup, fg_color_markup, CLOCK_ICON, CLOCK_FORMAT),

    -- format = string.format(
    --     "<span background='%s'>%s%s </span>",
    --     bg_color_markup, CLOCK_ICON, CLOCK_FORMAT),

    format = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s%s </span>",
        fg_color_markup, bg_color_markup, CLOCK_ICON, CLOCK_FORMAT),


}

local internal_textbox = {
    widget = wibox.widget.textbox,
    markup = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s</span>",
        fg_color_markup, bg_color_markup, "hi"),
}

local container_widget_table = {
    widget = wibox.container.background,
    bg = bg_color_widget,
    fg = fg_color_widget,
    border_width = border_width_widget,
    border_color = border_color_widget,
    children = {
        internal_textclock,
        internal_textbox,
    }
}

local clock_widget = wibox.widget(container_widget_table)

return function ()
    return clock_widget
end
