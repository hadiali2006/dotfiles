local require = require
local awful = require("awful")
local mod = require("binds.mod")
local widget = require("ui.wibar.module.volume")
return {
    awful.key({}, "XF86AudioPlay",
        function()
            awful.spawn.with_shell("playerctl play-pause")
        end,
        { description = "playerctl play/pause toggle", group = "custom" }
    ),
    awful.key({}, "XF86AudioNext",
        function()
            awful.spawn.with_shell("playerctl next")
        end,
        { description = "playerctl next", group = "custom" }
    ),
    awful.key({}, "XF86AudioPrev",
        function()
            awful.spawn.with_shell("playerctl previous")
        end,
        { description = "playerctl previous", group = "custom" }
    ),
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
            awful.spawn.with_shell("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+")
            widget():emit_signal("raise", 1)
        end,
        { description = "increase volume by 1%", group = "custom" }
    ),
    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
            awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-")
            widget():emit_signal("lower", 1)
        end,
        { description = "decrease volume by 1%", group = "custom" }
    ),
    awful.key({ mod.ctrl, },
        "XF86AudioRaiseVolume",
        function()
            awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
            awful.spawn.with_shell("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+")
            widget():emit_signal("raise", 5)
        end,
        { description = "increase volume by 5%", group = "custom" }
    ),
    awful.key({ mod.ctrl, }, "XF86AudioLowerVolume",
        function()
            awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
            awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
            widget():emit_signal("lower", 5)
        end,
        { description = "decrease volume by 5%", group = "custom" }
    ),
    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
            widget():emit_signal("togglemute")
        end,
        { description = "toggle mute", group = "audio" }
    ),
    awful.key({ mod.ctrl, }, "XF86AudioMute",
        function()
            awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
            widget():emit_signal("togglemute")
        end
    ),
}
