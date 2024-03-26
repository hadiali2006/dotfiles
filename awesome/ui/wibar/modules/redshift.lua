
local awful = require("awful")
local wibox = require("wibox")


local text_color_markup   = "#ffffff"
local bg_color_markup     = "#2f807f"

local bg_color_widget     = "#6888ff"
local fg_color_widget     = "#b0000f"
local border_color_widget = "#fff000"
local border_width_widget = 2

local internal_textbox = {
    widget = wibox.widget.textbox(),
    text = "hi"
}

local container_widget_table = {
    internal_textbox,
    widget = wibox.container.background,
    bg           = bg_color_widget,
    fg           = fg_color_widget,
    border_width = border_width_widget,
    border_color = border_color_widget,
}

local redshift_widget = internal_textbox.widget
local full_redshift_widget = wibox.widget(container_widget_table)

local function get_temp_from_redshift(callback)
end

return function ()
    return full_redshift_widget
end
