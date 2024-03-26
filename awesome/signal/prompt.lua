local awful = require("awful")

awesome.connect_signal("prompt::ddcutil::brightness", function()
    awful.prompt.run({
        prompt       = "<b> Set Brightness: </b>",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = function (input)
            if tonumber(tostring(input)) == nil then
                return
            else
                input = tonumber(input)
            end

            if input > 100 or input < 0 then
                return
            end

            awful.spawn.with_shell("ddcutil setvcp 10 " .. input)
            awesome.emit_signal("ddcutil::brightness::set::new", input)
        end,
    })
end)
