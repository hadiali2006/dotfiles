local require = require
local awful = require("awful")
local wibox = require("wibox")

return function(client)
    local buttons = {
        awful.button(nil, 1, function()
            client:activate({ context = "titlebar", action = "mouse_move" })
        end),
        awful.button(nil, 3, function()
            client:activate({ context = "titlebar", action = "mouse_resize" })
        end),
    }
    awful.titlebar(client).widget = wibox.widget({
        layout = wibox.layout.align.horizontal,
        -- Left
        {
            layout = wibox.layout.fixed.horizontal,
            awful.titlebar.widget.iconwidget(client),
            buttons = buttons,
        },
        -- Middle
        {
            layout = wibox.layout.flex.horizontal,
            { -- Title
                widget = awful.titlebar.widget.titlewidget(client),
                halign = "center",
            },
            buttons = buttons,
        },
        -- Right
        {
            layout = wibox.layout.fixed.horizontal,
            awful.titlebar.widget.floatingbutton(client),
            awful.titlebar.widget.maximizedbutton(client),
            awful.titlebar.widget.stickybutton(client),
            awful.titlebar.widget.ontopbutton(client),
            awful.titlebar.widget.closebutton(client),
        },
    })
end
