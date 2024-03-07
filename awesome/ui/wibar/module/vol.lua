local awful = require("awful")
local wibox = require("wibox")

local volWidget = wibox.widget.textbox()

local getVolume = function (callback)
    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@",
        function (stdout)
            if callback then
                local volume = math.floor(stdout:match('(%d%.%d+)')*100)
                local isMuted = stdout:match('MUTED')
                callback(volume, isMuted)
            end
        end)
end
getVolume(function (volume, isMuted)
    if isMuted then
        volWidget:set_text("x")
    else
        volWidget:set_text(volume)
    end
end)
awesome.connect_signal("signal::volume", function (action)
    local prev = volWidget.text
    if prev == "x" then
        getVolume(function (volume)
            if action == "inc" then
                volWidget:set_text(volume + 1)
            elseif action == "dec" then
                if (volume - 1) >= 0 then
                    volWidget:set_text(volume - 1)
                end
            end
        end)
    elseif action == "inc" then
        volWidget:set_text(prev + 1)
    elseif action == "dec" then
        if (prev - 1) >= 0 then
            volWidget:set_text(prev - 1)
        end
    elseif action == "mute" and prev ~= "x" then
        volWidget:set_text("x")
    end
end)
awesome.connect_signal("signal::volume::mod", function (action)
    local prev = volWidget.text
    if prev == "x" then
        getVolume(function (volume)
            if action == "inc" then
                volWidget:set_text(volume + 5)
            elseif action == "dec" then
                if (volume - 5) <= 0 then
                    volWidget:set_text(0)
                else
                    volWidget:set_text(volume - 5)
                end
            end
        end)
    elseif action == "inc" then
        volWidget:set_text(prev + 5)
    elseif action == "dec" then
        if (prev - 5) <= 0 then
            volWidget:set_text(0)
        else
            volWidget:set_text(prev - 5)
        end
    elseif action == "mute" and prev ~= "x" then
        volWidget:set_text("x")
    end
end)
volWidget.buttons = {
    awful.button(nil, 1, function()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        awesome.emit_signal("signal::volume", "mute")
    end),
    awful.button(nil, 3, function() 
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        awesome.emit_signal("signal::volume", "mute")
    end),
}

return function ()
    return volWidget
end
