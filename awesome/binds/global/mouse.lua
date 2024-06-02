local require = require
local awful = require("awful")
local ui_module = require("ui")
local mod = require("binds.mod")

awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function() ui_module.menu.main:toggle() end),
    awful.button({ mod.super, }, 4, awful.tag.viewprev),
    awful.button({ mod.super, }, 5, awful.tag.viewnext),
})
