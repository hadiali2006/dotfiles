local awful     = require("awful")
local beautiful = require("beautiful")

local menu = {}
local apps = require("config.apps")
local hkey_popup = require("awful.hotkeys_popup")

menu.awesome = {
    { "hotkeys",     function() hkey_popup.show_help(nil, awful.screen.focused()) end },
    { "manual",      apps.terminal .. " -e man awesome" },
    { "docs",        apps.browser .. " https://awesomewm.org/apidoc" },
    { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
}

menu.main = awful.menu({
    items = {
        { "awesome",         menu.awesome, beautiful.awesome_icon },
        { "open terminal",   apps.terminal },
        { "open browser",    apps.browser },
        { "exit to tty",     function() awesome.quit() end },
        { "restart", awesome.restart },
    }
})

return menu
