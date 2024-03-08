local awful = require("awful")
local wibox = require("wibox")
local volWidget = wibox.widget.textbox()

local function getTextAsNum(widgetText)
    local str = widgetText:match("<span.->(.-)</span>")
    return str
end

local function setText(strAsNum)
    local mu = string.format(" 󰋋 " .. "<span color='%s' bgcolor='%s'>%s</span>%%",
        "#12f1f3", "#ff3f22", strAsNum)
    volWidget:set_markup_silently(mu)
end

local getVolume = function (callback)
    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@",
        function (stdout)
            local volume = math.floor(stdout:match('(%d%.%d+)') * 100)
            local isMuted = stdout:match('MUTED')
            callback(volume, isMuted)
        end
    )
end

local function setVolumeFromShell(action, mod, volume)
    if action == "inc" then
        setText(volume + mod)
    elseif action == "dec" then
        if (volume - mod) <= 0 then
            setText(0)
        else
            setText(volume - mod)
        end
    elseif action == "mute" then
        setText(volume)
    end
end
awesome.connect_signal("volume::increase", function (action, mod)
    if getTextAsNum(volWidget:get_markup()) == "x" then
        getVolume(function (volume)
            setVolumeFromShell(action, mod, tostring(volume))
        end)
    else
        if(getTextAsNum(volWidget:get_markup()) + mod) >= 100 then
            setText(100)
        else
            setText(getTextAsNum(volWidget:get_markup()) + mod)
        end
    end
end)

awesome.connect_signal("volume::decrease", function (action, mod)
    if getTextAsNum(volWidget:get_markup()) == "x" then
        getVolume(function (volume)
            setVolumeFromShell(action, mod, tostring(volume))
        end)
    else
        if (getTextAsNum(volWidget:get_markup()) - mod) <= 0 then
            setText(0)
        else
            setText(getTextAsNum(volWidget:get_markup()) - mod)
        end
    end
end)

awesome.connect_signal("volume::togglemute", function ()
    if getTextAsNum(volWidget:get_markup()) == "x" then
        getVolume(function (volume)
            setText(volume)
        end)
    else
        setText("x")
    end
end)

volWidget.buttons = {
    awful.button(nil, 1, function()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        awesome.emit_signal("volume::togglemute", "mute")
    end),
    awful.button(nil, 3, function()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
        awesome.emit_signal("volume::togglemute", "mute")
    end),
}

return function ()
    getVolume(function (volume, isMuted)
        if isMuted then
            local mu = string.format(" 󰋋 " .. "<span color='%s' bgcolor='%s'>%s</span>" .. "%%",
                "#12f1f3", "#ff3f22", "x")
            volWidget:set_markup_silently(mu)
        else
            local mu = string.format(" 󰋋 " .. "<span color='%s' bgcolor='%s'>%s</span>" .. "%%",
                "#12f1f3", "#ff3f22", volume)
            volWidget:set_markup_silently(mu)
        end
    end)
    return volWidget
end
