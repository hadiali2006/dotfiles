local math, require, string = math, require, string
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local MAX_VOLUME = 100
local MIN_VOLUME = 0

local volume_commands = {
    increase = function(limit, amount)
        return string.format(
            "wpctl set-volume -l %.1f @DEFAULT_AUDIO_SINK@ %d%%+",
            limit, amount)
    end,
    decrease = function(amount)
        return string.format(
            "wpctl set-volume @DEFAULT_AUDIO_SINK@ %d%%-",
            amount)
    end,
    togglemute        = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
    unmute            = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0",
    get_volume_status = "wpctl get-volume @DEFAULT_AUDIO_SINK@",
}

local text_widget = wibox.widget.textbox()
local percent_widget = wibox.widget.textbox("%")

local icon_widget = wibox.widget.imagebox()

local volume_widget = wibox.widget({
    widget = wibox.container.margin,
    margins = {
        top    = beautiful.wibar_widget_margin,
        bottom = beautiful.wibar_widget_margin,
        right  = beautiful.wibar_widget_margin,
        left   = beautiful.wibar_widget_margin,
    },
    {
        widget = wibox.container.background,
        bg = beautiful.wibar_widget_bg,
        fg = beautiful.wibar_widget_fg,
        border_color = beautiful.wibar_widget_border_color,
        border_width = beautiful.wibar_widget_border_width,
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.textbox(" "),
            icon_widget,
            text_widget,
            percent_widget,
            wibox.widget.textbox(" "),
        },
    }
})

volume_widget.buttons = {
    awful.button(nil, 1,
        function()
            awful.spawn(volume_commands.togglemute, false)
            volume_widget:emit_signal("togglemute")
        end
    ),
    awful.button(nil, 3,
        function()
            awful.spawn(volume_commands.togglemute, false)
            volume_widget:emit_signal("togglemute")
        end
    ),
    awful.button(nil, 4,
        function()
            awful.spawn.with_shell(volume_commands.unmute)
            awful.spawn.with_shell(volume_commands.increase(MAX_VOLUME / 100, 1))
            volume_widget:emit_signal("raise", 1)
        end
    ),
    awful.button(nil, 5,
        function()
            awful.spawn.with_shell(volume_commands.unmute)
            awful.spawn.with_shell(volume_commands.decrease(1))
            volume_widget:emit_signal("lower", 1)
        end
    ),
}

---Given a function callback, gets current volume and mute status from wpctl within the shell.
---@param callback function: Arbritary function which passes in the volume and mute status.
local get_volume_from_wpctl = function(callback)
    awful.spawn.easy_async(
        volume_commands.get_volume_status,
        function(stdout)
            local volume = math.floor(stdout:match("Volume:%s+(%d+.%d+)") * 100 + 0.5)
            local is_muted = stdout:match("MUTED") and true or false
            callback(volume, is_muted)
        end
    )
end

---@param amount number
local increase_volume = function(amount)
    if text_widget.text + amount >= MAX_VOLUME then
        text_widget:set_markup_silently(MAX_VOLUME)
    else
        text_widget:set_markup_silently(text_widget.text + amount)
    end
end

---@param amount number
local decrease_volume = function(amount)
    if text_widget.text - amount <= MIN_VOLUME then
        text_widget:set_markup_silently(MIN_VOLUME)
    else
        text_widget:set_markup_silently(text_widget.text - amount)
    end
end

local signal_callbacks = {
    raise = function(_, amount)
        increase_volume(amount)
        if not text_widget.visible then
            icon_widget:set_image(beautiful.volume_icon_on)
            text_widget.visible = true
            percent_widget.visible = true
        end
    end,
    lower = function(_, amount)
        decrease_volume(amount)
        if not text_widget.visible then
            icon_widget:set_image(beautiful.volume_icon_on)
            text_widget.visible = true
            percent_widget.visible = true
        end
    end,
    togglemute = function(_)
        if text_widget.visible then
            icon_widget:set_image(beautiful.volume_icon_off)
            text_widget.visible = false
            percent_widget.visible = false
        else
            get_volume_from_wpctl(function(current_volume)
                text_widget:set_markup_silently(current_volume)
            end)
            icon_widget:set_image(beautiful.volume_icon_on)
            text_widget.visible = true
            percent_widget.visible = true
        end
    end,
}

do
    volume_widget:connect_signal("raise", signal_callbacks.raise)
    volume_widget:connect_signal("lower", signal_callbacks.lower)
    volume_widget:connect_signal("togglemute", signal_callbacks.togglemute)
end

do
    get_volume_from_wpctl(function(volume_status, is_muted)
        if is_muted then
            icon_widget:set_image(beautiful.volume_icon_off)
            text_widget.visible = false
            percent_widget.visible = false
        else
            icon_widget:set_image(beautiful.volume_icon_on)
            text_widget:set_markup_silently(volume_status)
        end
    end)
end

return function() return volume_widget end
