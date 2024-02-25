local awful = require("awful")

local widgets = require("ui")

local mod = require("binds.mod")
local modkey = mod.modkey

awful.mouse.append_global_mousebindings({
	awful.button(nil, 3, function()
		widgets.menu.main:toggle()
	end),
	awful.button({ modkey }, 4, awful.tag.viewprev),
	awful.button({ modkey }, 5, awful.tag.viewnext),
})
