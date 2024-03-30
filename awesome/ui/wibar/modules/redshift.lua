-- local naughty = require("naughty")
--
-- -- Function to create and show a notification
-- local function notif(title, message)
--     naughty.notify({
--         title = title,
--         text = message,
--         timeout = 5,  -- Timeout in seconds
--         position = "top_right"  -- Position of the notification
--     })
-- end
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local theme = beautiful.modules.redshift

local DAYTIME_ICON = theme.icon.daytime
local NIGHT_ICON = theme.icon.night
local TEMPERATURE_ICON = theme.icon.temperature


local bg_color_markup     = theme.widget.markup.background
local fg_color_markup     = theme.widget.markup.foreground
local bg_alpha_markup     = theme.widget.markup.alpha

local bg_color_widget     = theme.widget.background_container.background
local fg_color_widget     = theme.widget.background_container.foreground
local border_color_widget = theme.widget.background_container.border_color
local border_width_widget = theme.widget.background_container.border_width


local internal_temperature_textbox = {
    widget = wibox.widget.textbox(),
}

local internal_period_textbox = {
    widget = wibox.widget.textbox(),
}

local internal_temperature_icon_textbox = {
    widget = wibox.widget.textbox(),
}

local internal_period_icon_textbox = {
    widget = wibox.widget.textbox(),
}

local container_widget_table = {
    {
        {
            {
                internal_temperature_icon_textbox,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                internal_temperature_textbox,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                internal_period_icon_textbox,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                internal_period_textbox,
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

local period_widget           = internal_period_textbox.widget
local temperature_widget      = internal_temperature_textbox.widget
local period_icon_widget      = internal_period_icon_textbox.widget
local temperature_icon_widget = internal_temperature_icon_textbox.widget
local full_redshift_widget    = wibox.widget(container_widget_table)

local function get_temp_from_redshift(callback)
    awful.spawn.easy_async("redshift -p", function(stdout)
        local temp_value = stdout:match("Color temperature: (.-)\n")
        local period_value = stdout:match("Period: (.-)\n")
        callback(temp_value, period_value)
    end)
end

return function ()
    get_temp_from_redshift(function (temp, period)
        temperature_icon_widget:set_markup_silently(string.format(
            "<span color='%s' bgcolor='%s' bgalpha='%s'>%s</span>",
            fg_color_markup, bg_color_markup, bg_alpha_markup, TEMPERATURE_ICON))

        temperature_widget:set_markup_silently(string.format(
            "<span color='%s' bgcolor='%s' bgalpha='%s'>%s</span>",
            fg_color_markup, bg_color_markup, bg_alpha_markup, temp))

        period_icon_widget:set_markup_silently(string.format(
            "<span color='%s' bgcolor='%s' bgalpha='%s'>%s</span>",
            fg_color_markup, bg_color_markup, bg_alpha_markup, DAYTIME_ICON))

        period_widget:set_markup_silently(string.format(
            "<span color='%s' bgcolor='%s' bgalpha='%s'>%s </span>",
            fg_color_markup, bg_color_markup, bg_alpha_markup, period))
    end)
    return full_redshift_widget
end
