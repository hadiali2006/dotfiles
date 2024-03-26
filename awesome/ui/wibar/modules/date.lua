--
-- local naughty = require("naughty")
--
-- -- Function to create and show a notification
-- local function notif(title, message)
--     naughty.notify({
--         title = title,
--         text = message,
--         timeout = 1,
--         position = "top_right"  -- Position of the notification
--     })
-- end
--
--
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

local CALENDER_ICON       = " 󰃭 "
local DATE_FORMAT         = "%a %B %d"

local bg_color_markup     = beautiful.widget.bg_markup
local fg_color_markup     = beautiful.widget.fg_markup

local bg_color_widget     = beautiful.widget.bg_widget
local fg_color_widget     = beautiful.widget.fg_widget
local border_color_widget = beautiful.widget.border_widget
local border_width_widget = beautiful.widget.border_size

local border_color_popup = beautiful.widget.border_popup

local internal_textclock = {
    widget = wibox.widget.textclock(),
    format = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s%s </span>",
        fg_color_markup, bg_color_markup, CALENDER_ICON, DATE_FORMAT),
}

local container_widget_table = {
    internal_textclock,
    widget       = wibox.container.background,
    bg           = bg_color_widget,
    fg           = fg_color_widget,
    border_width = border_width_widget,
    border_color = border_color_widget,
}


local date_widget = internal_textclock.widget
local full_date_widget = wibox.widget(container_widget_table)

local pop = awful.popup {
    widget = {
        {
            {
                widget = wibox.widget.calendar.month(os.date("*t"))
            },
            layout = wibox.layout.fixed.horizontal,
        },
        margins = 11,
        widget  = wibox.container.margin
    },
    bind_to_widget = full_date_widget,
    hide_on_right_click = true,
    border_color = border_color_popup,
    border_width = 5,

    x = 1727 - 7,
    y = 33 + 5,
    visible = false,
    ontop = true,
}


date_widget.buttons = {
    awful.button(nil, 1, function()
        if(pop.visible) then
            pop.visible = false
        else
            pop.visible = true
        end
    end),
    awful.button(nil, 3, function()
        if(pop.visible) then
            pop.visible = false
        else
            pop.visible = true
        end
    end),
}

return function ()
    return full_date_widget
end
