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
-- local helpers = require("helpers")
local wibox = require("wibox")

local module = require(... .. ".modules")

return function(s)
    s.mypromptbox = awful.widget.prompt()

    s.mywibox = awful.wibar({
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            -- Left widgets.
            {
                layout = wibox.layout.fixed.horizontal,
                module.systray(),
                -- module.launcher(),
                module.taglist(s),
                s.mypromptbox
            },
            -- Middle widgets.
            module.tasklist(s),
            -- Right widgets.
            {
                layout = wibox.layout.fixed.horizontal,
                -- module.redshift(),
                module.brightness(),
                module.volume(),
                module.time(),
                module.date(),
                module.layoutbox(s),


            }
        }
    })
    -- notif(tostring(s.mywibox.height))
end
