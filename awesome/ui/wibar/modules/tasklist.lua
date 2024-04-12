local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")


return function(s)
    return awful.widget.tasklist({
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        layout  = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness     = 1,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            spacing = 9,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 3,
                id            = "background_role",
                widget        = wibox.container.background,
            },
            {
                {
                    awful.widget.clienticon,
                    -- valign = "center",
                    -- halign = "center",
                    widget  = wibox.container.place
                },
                margins = 5,
                widget  = wibox.container.margin
            },
            nil,
            layout = wibox.layout.align.vertical,
        },
        buttons = {
            awful.button(nil, 1, function(c)
                c:activate({ context = "tasklist", action = "toggle_minimization" })
            end),
            awful.button(nil, 3, function() awful.menu.client_list({ theme = { width = 750 } }) end),
            awful.button(nil, 4, function() awful.client.focus.byidx(-1) end),
            awful.button(nil, 5, function() awful.client.focus.byidx( 1) end)
        }
    })
end
