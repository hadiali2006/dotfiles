local require = require
local awful = require("awful")
local beautiful = require("beautiful")
local mod = require("binds.mod")
local dpi = beautiful.xresources.dpi


local gap = {
    table = { 0, 5 },
    index = 1,
}

return {
    awful.key(
        { mod.super, },
        "o",
        function()
            beautiful.useless_gap = dpi(gap.table[gap.index])
            if gap.index < 2 then
                gap.index = gap.index + 1
            else
                gap.index = 1
            end
            awful.screen.connect_for_each_screen(function(s)
                awful.layout.arrange(s)
            end)
        end,
        { description = "toggle gaps", group = "ui" }
    ),
}
