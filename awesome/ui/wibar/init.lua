local awful = require("awful")
-- local helpers = require("helpers")
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
                -- wibox.widget{
                --     widget = wibox.widget.textbox(),
                --     markup = helpers.misc.colorize({
                --         text = "g",
                --         fg = "#f45434",
                --     })
                -- },
                module.vol(),
                wibox.widget.textclock(" %r %A %B %d ", 1),
                -- module.cal(),
                module.layoutbox(s),
            }
        }
    })
end
