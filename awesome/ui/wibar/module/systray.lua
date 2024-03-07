local wibox     = require("wibox")
local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")
local systray = wibox.widget.systray()

return function ()
    return systray
end
