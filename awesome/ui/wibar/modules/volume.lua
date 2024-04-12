local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")

local theme = beautiful.modules.volume

local MAX_VOLUME           = 100
local MIN_VOLUME           = 0
local volume_icon          = theme.icon.volume
local mute_icon            = theme.icon.mute
local percent_icon         = theme.icon.percent

local icon_widget_bg_color = theme.icon.background_container.background
local icon_widget_fg_color = theme.icon.background_container.foreground

local bg_color_markup      = theme.widget.markup.background
local fg_color_markup      = theme.widget.markup.foreground
local bg_alpha_markup      = theme.widget.markup.alpha

local bg_color_widget      = theme.widget.background_container.background
local fg_color_widget      = theme.widget.background_container.foreground
local border_color_widget  = theme.widget.background_container.border_color
local border_width_widget  = theme.widget.background_container.border_width

local internal_svg_imagebox = {
    widget = wibox.widget.imagebox(),
    image = volume_icon,
    resize = true
}

local internal_volume_textbox = {
    widget = wibox.widget.textbox()
}

local thin_space = {
    widget = wibox.widget.textbox(beautiful.thin_space),
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
                bg     = icon_widget_bg_color,
                fg     = icon_widget_fg_color,
            },
            {
                thin_space,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                internal_volume_textbox,
                widget = wibox.container.background,
                bg     = bg_color_widget,
                fg     = fg_color_widget,
            },
            {
                wibox.widget.textbox(" "),
                widget = wibox.container.background,
                bg     = icon_widget_bg_color,
                fg     = icon_widget_fg_color,
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

local volume_widget      = internal_volume_textbox.widget
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

full_volume_widget.buttons = {
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

---Given a function callback, gets current volume and mute status from wpctl within the shell.
---@param callback (function): Arbritary function which passes in the volume and mute status.
local function get_volume_from_wpctl(callback)
    awful.spawn.easy_async(volume_commands.get_volume_status,
        function (stdout)
            local volume   = math.floor(stdout:match("Volume:%s+(%d+.%d+)") * 100 + 0.5)
            local is_muted = stdout:match("MUTED") and true or false
            callback(volume, is_muted)
        end)
end

---Get the current volume from markup text.
---@param widget_markup string: Current markup text in widget.
---@return string?: Parsed volume from markup text. nil if volume is muted at startup.
local function get_volume_from_markup(widget_markup)
    if widget_markup then
        return widget_markup:match(string.format(
        "<span.->(.-)%s</span>", "%" .. percent_icon))
    end
end

---Set volume status within textbox widget markup.
---@param new_content number|string: Volume to set into markup of volume widget. Empty string if muting or current volume as a number.
local function set_volume_widget_content(new_content)
    volume_widget:set_markup_silently(string.format(
        "<span color='%s' bgcolor='%s'>%s%s</span>",
        fg_color_markup, bg_color_markup, new_content, percent_icon))
end

---Increase volume in the widget.
---@param volume number|string: Volume to set into volume widget. String when parsed from markup or number when parsed from wpctl stdout.
---@param mod number: The amount the volume will be increased.
local function increase_volume(volume, mod)
    if(volume + mod) >= MAX_VOLUME then
        set_volume_widget_content(MAX_VOLUME)
    else
        set_volume_widget_content(volume + mod)
    end
end

---Decrease volume in the widget.
---@param volume (number|string?): Volume to set into volume widget. String when parsed from markup or number when parsed from wpctl stdout.
---@param mod number: The amount the volume will be decreased.
local function decrease_volume(volume, mod)
    if (volume - mod) <= MIN_VOLUME then
        set_volume_widget_content(MIN_VOLUME)
    else
        set_volume_widget_content(volume - mod)
    end
end

awesome.connect_signal("volume::increase", function (mod)
    local parsed_volume = get_volume_from_markup(volume_widget:get_markup())
    if not volume_widget.visible then
        get_volume_from_wpctl(function (volume)
            increase_volume(volume, mod)
        end)
        thin_space.widget.visible = true
        volume_widget.visible     = true
        percent_icon              = theme.icon.percent
        internal_svg_imagebox.widget:set_image(volume_icon)
    elseif parsed_volume then
            increase_volume(parsed_volume, mod)
    end
end)

awesome.connect_signal("volume::decrease", function (mod)
    local parsed_volume = get_volume_from_markup(volume_widget:get_markup())
    if not volume_widget.visible then
        get_volume_from_wpctl(function (volume)
            decrease_volume(volume, mod)
        end)
        thin_space.widget.visible = true
        volume_widget.visible     = true
        percent_icon              = theme.icon.percent
        internal_svg_imagebox.widget:set_image(volume_icon)
    elseif parsed_volume then
            decrease_volume(parsed_volume, mod)
    end
end)

awesome.connect_signal("volume::togglemute", function ()
    if not volume_widget.visible then
        get_volume_from_wpctl(function (volume)
            set_volume_widget_content(volume)
        end)
        thin_space.widget.visible = true
        volume_widget.visible     = true
        percent_icon              = theme.icon.percent
        internal_svg_imagebox.widget:set_image(volume_icon)
    else
        thin_space.widget.visible = false
        volume_widget.visible = false
        percent_icon          = ""
        internal_svg_imagebox.widget:set_image(mute_icon)
    end
end)

---@return wibox.widget.base: Return container widget to be added to wibar.
return function ()
    get_volume_from_wpctl(function (volume_status, is_muted)
        if is_muted then
            thin_space.widget.visible = false
            volume_widget.visible     = false
            percent_icon              = ""
            internal_svg_imagebox.widget:set_image(mute_icon)
        else
            internal_svg_imagebox.widget:set_image(volume_icon)
            set_volume_widget_content(volume_status)
        end
    end)
    return full_volume_widget
end
