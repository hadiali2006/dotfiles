local awful = require("awful")
local wibox = require("wibox")

local module = require(... .. ".module")

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
                module.launcher(),
                module.taglist(s),
                s.mypromptbox
            },
            -- Middle widgets.
            module.tasklist(s),
            -- Right widgets.
            {
                layout = wibox.layout.fixed.horizontal,
                module.systray(),
                wibox.widget.textbox(" 󰋋 "),
                module.vol(),
                wibox.widget.textbox("%"),
                wibox.widget.textclock(" %r %A %B %d ", 1),
                -- module.cal(),
                module.layoutbox(s),
            }
        }
    })
end
