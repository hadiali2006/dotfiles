local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi
local theme = beautiful.modules.time

local CLOCK_ICON                = theme.icon.clock
local CLOCK_UPDATE_RATE_IN_SECONDS = 1
local CLOCK_FORMAT              = "%I:%M:%S %p"

local bg_color_markup     = theme.widget.markup.background
local fg_color_markup     = theme.widget.markup.foreground

local bg_color_widget     = theme.widget.background_container.background
local fg_color_widget     = theme.widget.background_container.foreground
local border_color_widget = theme.widget.background_container.border_color
local border_width_widget = theme.widget.background_container.border_width


local internal_svg_imagebox = {
    widget = wibox.widget.imagebox(),
    image = theme.icon.clock_svg,
    resize = true,
    valign = "center",
    halign = "center",
    -- forced_width  = ,
    -- forced_height  = 18,
    scaling_quality = "best"
}

local internal_widget_textclock = {
    widget = wibox.widget.textclock,
    refresh = CLOCK_UPDATE_RATE_IN_SECONDS,
    format = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s </span>",
        fg_color_markup, bg_color_markup, CLOCK_FORMAT),
}

local internal_icon_textbox = {
    widget = wibox.widget.textbox,
    markup = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s</span>",
        fg_color_markup, bg_color_markup, CLOCK_ICON),
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
                internal_widget_textclock,
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

local clock_widget = wibox.widget(container_widget_table)

return function ()
    return clock_widget
end
