local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local MAX_VOLUME          = 100
local MIN_VOLUME          = 0

local volume_icon         = " 󰕾 "
local const_volume_icon   = " 󰕾 "

local percent_icon        = "% "
local const_percent_icon  = "% "

local mute_icon           = " 󰖁 "

local bg_color_markup     = beautiful.widget.bg_markup
local fg_color_markup     = beautiful.widget.fg_markup

local bg_color_widget     = beautiful.widget.bg_widget
local fg_color_widget     = beautiful.widget.fg_widget
local border_color_widget = beautiful.widget.border_widget
local border_width_widget = beautiful.widget.border_size

local internal_textbox = {
    widget = wibox.widget.textbox()
}

local container_widget_table = {
    internal_textbox,
    widget       = wibox.container.background,
    bg           = bg_color_widget,
    fg           = fg_color_widget,
    border_width = border_width_widget,
    border_color = border_color_widget,
}

local volume_widget      = internal_textbox.widget
local full_volume_widget = wibox.widget(container_widget_table)

local volume_commands = {
    increase = function (limit, mod)
        return string.format(
            "wpctl set-volume -l %.1f @DEFAULT_AUDIO_SINK@ %d%%+",
            limit, mod)
    end,
    decrease = function (mod)
        return string.format(
            "wpctl set-volume @DEFAULT_AUDIO_SINK@ %d%%-",
            mod)
    end,
    togglemute        = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
    unmute            = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0",
    get_volume_status = "wpctl get-volume @DEFAULT_AUDIO_SINK@",
}

volume_widget.buttons = {
    awful.button(nil, 1, function()
        awful.spawn(volume_commands.togglemute, false)
        awesome.emit_signal("volume::togglemute")
    end),
    awful.button(nil, 3, function()
        awful.spawn(volume_commands.togglemute, false)
        awesome.emit_signal("volume::togglemute")
    end),
    awful.button(nil, 4, function()
        awful.spawn.with_shell(volume_commands.unmute)
        awful.spawn.with_shell(volume_commands.increase(MAX_VOLUME / 100, 1))
        awesome.emit_signal("volume::increase", 1)
    end),
    awful.button(nil, 5, function()
        awful.spawn.with_shell(volume_commands.unmute)
        awful.spawn.with_shell(volume_commands.decrease(1))
        awesome.emit_signal("volume::decrease", 1)
    end),
}

--- Given a function callback, gets current volume and mute status from wpctl within the shell.
--- @param callback (function): Arbritary function which passes in the volume and mute status.
local function get_volume_from_wpctl(callback)
    awful.spawn.easy_async(volume_commands.get_volume_status,
        function (stdout)
            local volume   = math.floor(stdout:match("Volume:%s+(%d+.%d+)") * 100 + 0.5)
            local is_muted = stdout:match("MUTED") and true or false
            callback(volume, is_muted)
        end)
end

--- Get the current volume from markup text.
--- @param widget_markup (string): Current markup text in widget.
--- @return (string): Parsed volume from markup text.
local function get_volume_from_markup(widget_markup)
    return widget_markup:match(
        string.format("<span.->%s(.-)%s</span>",
            volume_icon, "%" .. percent_icon))
end

--- Set volume within widget markup.
--- @param volume (number|string): Volume to set into markup of volume widget. Empty string if muting or current volume as a number.
local function set_widget_volume(volume)
    volume_widget:set_markup_silently(string.format(
        "<span color='%s' bgcolor='%s'>%s%s%s</span>",
        fg_color_markup, bg_color_markup, volume_icon, volume, percent_icon))
end

--- Increase volume in the widget.
--- @param volume (number|string): Volume to set into volume widget. String when parsed from markup or number when parsed from wpctl stdout.
--- @param mod (number): The amount the volume will be increased.
local function increase_volume(volume, mod)
    if(volume + mod) >= MAX_VOLUME then
        set_widget_volume(MAX_VOLUME)
    else
        set_widget_volume(volume + mod)
    end
end

--- Decrease volume in the widget.
--- @param volume (number|string): Volume to set into volume widget. String when parsed from markup or number when parsed from wpctl stdout.
--- @param mod (number): The amount the volume will be decreased.
local function decrease_volume(volume, mod)
    if (volume - mod) <= MIN_VOLUME then
        set_widget_volume(MIN_VOLUME)
    else
        set_widget_volume(volume - mod)
    end
end

awesome.connect_signal("volume::increase", function (mod)
    local parsed_volume = get_volume_from_markup(volume_widget:get_markup())
    if parsed_volume == mute_icon then
        get_volume_from_wpctl(function (volume)
            increase_volume(volume, mod)
        end)
        percent_icon = const_percent_icon
        volume_icon  = const_volume_icon
    else
        if(parsed_volume + mod) >= MAX_VOLUME then
            set_widget_volume(MIN_VOLUME)
        else
            increase_volume(parsed_volume, mod)
        end
    end
end)

awesome.connect_signal("volume::decrease", function (mod)
    local parsed_volume = get_volume_from_markup(volume_widget:get_markup())
    if parsed_volume == mute_icon then
        get_volume_from_wpctl(function (volume)
            decrease_volume(volume, mod)
        end)
        percent_icon = const_percent_icon
        volume_icon  = const_volume_icon
    else
        if (parsed_volume - mod) <= MIN_VOLUME then
            set_widget_volume(MIN_VOLUME)
        else
            decrease_volume(parsed_volume, mod)
        end
    end
end)

awesome.connect_signal("volume::togglemute", function ()
    local parsed_volume = get_volume_from_markup(volume_widget:get_markup())
    if parsed_volume == mute_icon then
        get_volume_from_wpctl(function (volume)
            set_widget_volume(volume)
        end)
        percent_icon = const_percent_icon
        volume_icon  = const_volume_icon
    else
        percent_icon = ""
        volume_icon  = ""
        set_widget_volume(mute_icon)
    end
end)

--- @return (wibox.widget.base): Return container widget to be added to wibar.
return function ()
    get_volume_from_wpctl(function (volume, is_muted)
        if is_muted then
            percent_icon = ""
            volume_icon  = ""
            volume_widget:set_markup_silently(string.format(
                "<span color='%s' bgcolor='%s'>%s%s%s</span>",
                fg_color_markup, bg_color_markup, volume_icon, mute_icon, percent_icon))
        else
            volume_widget:set_markup_silently(string.format(
                "<span color='%s' bgcolor='%s'>%s%s%s</span>",
                fg_color_markup, bg_color_markup, volume_icon, volume, percent_icon))
        end
    end)
    return full_volume_widget
end
