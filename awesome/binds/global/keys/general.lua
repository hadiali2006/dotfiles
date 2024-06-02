local require = require
local capi = { awesome = awesome }
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local ui_module = require("ui")
local mod = require("binds.mod")
local apps = require("config.apps")

local binds = {
    awful.key({ mod.super }, "s",
        hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }
    ),
    awful.key({ mod.super, mod.shift }, "w",
        function()
            ui_module.menu.main:show()
        end,
        { description = "show main menu", group = "awesome", }
    ),
    awful.key({ mod.super, mod.ctrl }, "r",
        capi.awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),
    awful.key({ mod.super, mod.shift }, "q",
        --TODO: add conformation
        capi.awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),
    awful.key({ mod.super }, "x",
        function()
            awful.prompt.run({
                prompt       = " <b>Run Lua code:</b> ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            })
        end,
        { description = "lua execute prompt", group = "awesome" }
    ),
    awful.key({ mod.super }, "r",
        function()
            awful.prompt.run({
                prompt       = " <b>Run:</b> ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = function(input)
                    awful.spawn.with_shell(input)
                end,
                completion_callback = awful.completion.shell,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            })
        end,
        { description = "run prompt", group = "launcher" }
    ),
    awful.key({ mod.super }, "p",
        function()
            menubar.show()
        end,
        { description = "show the menubar", group = "launcher" }
    ),
    awful.key({ mod.super }, "Return",
        function()
            awful.spawn(apps.terminal)
        end,
        { description = "open a terminal", group = "launcher" }
    ),
    awful.key({ mod.super, }, "a",
        function()
            awful.spawn.with_shell(apps.browser)
        end,
        { description = "launch browser", group = "launcher" }
    ),
    awful.key({ mod.super, },
        "z",
        function()
            awful.spawn.with_shell("rofi -show drun")
        end,
        { description = "launch rofi", group = "launcher" }
    ),
    awful.key({ mod.super, mod.alt }, "End",
        function()
            awful.spawn.with_shell("systemctl suspend")
        end,
        { description = "sleep", group = "custom" }
    ),
}

return binds
