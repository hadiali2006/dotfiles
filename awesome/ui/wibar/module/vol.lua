local awful = require("awful")
local wibox = require("wibox")

local volWidget = wibox.widget.textbox()

local decoIcon         = " 󰕾 "
local constdecoIcon    = " 󰕾 "
local muteIcon         = " 󰖁 "
local constPercentIcon = "% "
local percentIcon      = "% "
local textcolor        = "#ffffff"
local bgcolor          = "#2f807f"

local function getVolume(callback)
    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@",
        function (stdout)
            local volume  = math.floor(stdout:match("Volume:%s+(%d+.%d+)") * 100 + 0.5)
            local isMuted = stdout:match("MUTED")
            callback(volume, isMuted)
        end)
end

local function getVolumeFromHTML(widgetText)
    return widgetText:match(
        string.format("<span.->%s(.-)%s</span>",
            decoIcon, "%" .. percentIcon))
end

local function setText(strAsNum)
    volWidget:set_markup_silently(string.format(
        "<span color='%s' bgcolor='%s'>%s%s%s</span>",
        textcolor, bgcolor, decoIcon, strAsNum, percentIcon))
end

local function setVolumeFromShell(action, mod, volume)
    if action == "inc" then
        if(volume + mod) >= 100 then
            setText(100)
        else
            setText(volume + mod)
        end
    elseif action == "dec" then
        if (volume - mod) <= 0 then
            setText(0)
        else
            setText(volume - mod)
        end
    end
end

awesome.connect_signal("volume::increase", function (action, mod)
    local parsedVolume = getVolumeFromHTML(volWidget:get_markup())
    if parsedVolume == muteIcon then
        getVolume(function (volume)
            setVolumeFromShell(action, mod, volume)
        end)
        percentIcon = constPercentIcon
        decoIcon    = constdecoIcon
    else
        if(parsedVolume + mod) >= 100 then
            setText(100)
        else
            setText(parsedVolume + mod)
        end
    end
end)

awesome.connect_signal("volume::decrease", function (action, mod)
    local parsedVolume = getVolumeFromHTML(volWidget:get_markup())
    if parsedVolume == muteIcon then
        getVolume(function (volume)
            setVolumeFromShell(action, mod, volume)
        end)
        percentIcon = constPercentIcon
        decoIcon    = constdecoIcon
    else
        if (parsedVolume - mod) <= 0 then
            setText(0)
        else
            setText(parsedVolume - mod)
        end
    end
end)

awesome.connect_signal("volume::togglemute", function ()
    local parsedVolume = getVolumeFromHTML(volWidget:get_markup())
    if parsedVolume == muteIcon then
        getVolume(function (volume)
            setText(volume)
        end)
        decoIcon    = constdecoIcon
        percentIcon = constPercentIcon
    else
        percentIcon = ""
        decoIcon    = ""
        setText(muteIcon)
    end
end)

volWidget.buttons = {
    awful.button(nil, 1, function()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
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
            percentIcon = ""
            decoIcon    = ""
            volWidget:set_markup_silently(string.format(
                "<span color='%s' bgcolor='%s'>%s%s%s</span>",
                textcolor, bgcolor, decoIcon, muteIcon, percentIcon))
        else
            volWidget:set_markup_silently(string.format(
                "<span color='%s' bgcolor='%s'>%s%s%s</span>",
                textcolor, bgcolor, decoIcon, volume, percentIcon))
        end
    end)
    return volWidget
end