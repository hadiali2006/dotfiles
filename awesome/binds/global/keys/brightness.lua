local require, tonumber, tostring = require, tonumber, tostring
local awful = require("awful")
local mod = require("binds.mod")
local widget = require("ui.wibar.module.ddcutil")
return {
    awful.key(
        { mod.super, },
        "d",
        function ()
            widget():emit_signal("set::current")
        end,
        {
            description = "set monitor brightness w/ ddcutil",
            group = "custom"
        }
    ),
    awful.key(
        { mod.super, }, "b",
        function()
            awful.prompt.run({
                prompt       = "<b> Set Brightness: </b>",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = function(input)
                    if tonumber(tostring(input)) == nil then return end
                    input = tonumber(input)
                    if input > 100 or input < 0 then return end
                    awful.spawn.with_shell("ddcutil setvcp 10 " .. input)
                    widget():emit_signal("set::new", input)
                end,
            })
        end,
        { description = "set monitor brightness w/ ddcutil", group = "brightness" }
    ),
}
