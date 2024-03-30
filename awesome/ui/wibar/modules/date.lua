
local naughty = require("naughty")

-- Function to create and show a notification
local function notif(title, message)
    naughty.notify({
        title = title,
        text = message,
        timeout = 1,
        position = "top_right"  -- Position of the notification
    })
end


local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local theme = beautiful.modules.date
local dpi = beautiful.xresources.apply_dpi

local DATE_FORMAT         = "%a %B %d"
local CALENDAR_ICON       = theme.icon.calendar

local bg_color_markup     = theme.widget.markup.background
local fg_color_markup     = theme.widget.markup.foreground

local bg_color_widget     = theme.widget.background_container.background
local fg_color_widget     = theme.widget.background_container.foreground
local border_color_widget = theme.widget.background_container.border_color
local border_width_widget = theme.widget.background_container.border_width

local border_color_popup  = theme.popup.border_color
local border_width_popup  = theme.popup.border_width

local internal_widget_textclock = {
    widget = wibox.widget.textclock,
    format = string.format(
        "<span color='%s' bgcolor='%s' bgalpha='65535'>%s </span>",
        fg_color_markup, bg_color_markup, DATE_FORMAT),
}

-- local internal_icon_textbox = {
--     widget = wibox.widget.textbox,
--     markup = string.format(
--         "<span color='%s' bgcolor='%s' bgalpha='65535'>%s</span>",
--         fg_color_markup, bg_color_markup, CALENDAR_ICON),
-- }
local internal_svg_imagebox = {
    widget = wibox.widget.imagebox(),
    image = theme.icon.calendar_svg,
    resize = true,
    valign = "center",
    halign = "center",
    forced_width  = 20,
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


local date_widget = internal_widget_textclock.widget
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
    border_width = border_width_popup,

    x = 1727 - 7,
    y = 33 + 5,
    visible = false,
    ontop = true,
}


full_date_widget.buttons = {
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
