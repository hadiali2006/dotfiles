local require, tostring = require, tostring
local awful = require("awful")
local naughty = require("naughty")
local sss
sss = {
    saved_screenshot = function(args)
        args.directory = "~/screenshots"
        local ss = awful.screenshot(args)

        local function notify(self)
            naughty.notification {
                title     = self.file_name,
                message   = "Screenshot saved",
                icon      = self.surface,
                icon_size = 128,
            }
        end

        if args.auto_save_delay > 0 then
            ss:connect_signal("file::saved", notify)
        else
            notify(ss)
        end

        return ss
    end,
    delayed_screenshot = function(args)
        args.directory = "~/screenshots"
        local ss = sss.saved_screenshot(args)
        local notif = naughty.notification {
            title   = "Screenshot in:",
            message = tostring(args.auto_save_delay) .. " seconds"
        }

        ss:connect_signal("timer::tick", function(_, remain)
            notif.message = tostring(remain) .. " seconds"
        end)

        ss:connect_signal("timer::timeout", function()
            if notif then notif:destroy() end
        end)

        return ss
    end
}
return {
    awful.key({}, "Print",
        function ()
            sss.saved_screenshot({ auto_save_delay = 0 })
        end,
        { description = "take screenshot", group = "client" }),
    awful.key({"Shift"}, "Print",
        function ()
            sss.saved_screenshot({ auto_save_delay = 0, interactive = true })
        end,
        { description = "take interactive screenshot", group = "client" }),
    awful.key({"Control"}, "Print",
        function ()
            sss.delayed_screenshot({ auto_save_delay = 5 })
        end ,
        { description = "take screenshot in 5 seconds", group = "client" }),
    awful.key({"Shift", "Control"}, "Print",
        function ()
            sss.delayed_screenshot({ auto_save_delay = 5, interactive = true })
        end ,
        { description = "take interactive screenshot in 5 seconds", group = "client" }
    ),
}
