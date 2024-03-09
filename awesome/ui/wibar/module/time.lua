local awful = require("awful")
local wibox = require("wibox")
local clockWidget = wibox.widget.textclock("  %r  󰃭 %a %B %d ", 1)
return function ()
    return clockWidget
end


