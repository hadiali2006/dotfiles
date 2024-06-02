local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

return function(s)
    local tasklst = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate({ context = "tasklist", action = "toggle_minimization" })
            end),
        },
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = 8,
        },
        style = {
            shape_border_width = 1,
            shape_border_color = "#b3b9b8",
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = "icon_role",
                                widget = wibox.widget.imagebox,
                                forced_height = dpi(20),
                            },
                            margins = {
                                top    = dpi(3),
                                bottom = dpi(3),
                                left   = dpi(3),
                                right  = dpi(3),
                            },
                            widget = wibox.container.margin,
                        },
                        widget = wibox.container.constraint,
                        width = dpi(80),
                    },
                    margins = {
                        left = dpi(10),
                        right = dpi(10),
                    },
                    widget = wibox.container.margin,
                },
                id = "background_role",
                widget = wibox.container.background,
            },
            margins = {
                top    = dpi(2),
                bottom = dpi(2),
                left   = dpi(2),
                right  = dpi(2),
            },
            widget = wibox.container.margin,
        },
    })
    return tasklst
end
