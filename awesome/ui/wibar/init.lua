local awful = require("awful")
local wibox = require("wibox")

local module = require(... .. ".module")

local left_widgets = function(s)
    return {
        {
            wibox.widget.textbox(" "),
            -- module.launcher(),
            module.menu(),
            module.volume(),
            module.brightness(),
            -- module.taglist(s),
            spacing = 15,
            spacing_widget = wibox.widget.separator,
            layout = wibox.layout.fixed.horizontal,
        },
        s.mypromptbox,
        layout = wibox.layout.fixed.horizontal,
    }
end

local middle_widget = function(s)
    return {
        -- widget = module.tasklist(s),
        widget = module.taglist(s),
    }
end

local right_widgets = function(s)
    return {
        module.time(),
        module.date(),
        module.layoutbox(s),
        wibox.widget.textbox(" "),
        spacing = 15,
        spacing_widget = wibox.widget.separator,
        layout = wibox.layout.fixed.horizontal,
    }
end

return function(screen)
    screen.mypromptbox = awful.widget.prompt()
    screen.mywibox = awful.wibar({
        position = "top",
        screen = screen,
        widget = {
            expand = "none",
            layout = wibox.layout.align.horizontal,
            left_widgets(screen),
            middle_widget(screen),
            right_widgets(screen),
        },
    })
end
