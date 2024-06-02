local pairs, require = pairs, require
local awful = require("awful")
local wm = require(... .. ".wm")
local bindings = {
    require(... .. ".general"),
    wm.focus,
    wm.layout,
    wm.tag,
    require(... .. ".scratchpad"),
    require(... .. ".audio"),
    require(... .. ".brightness"),
    require(... .. ".screenshot"),
    require(... .. ".ui"),
}

for _, v in pairs(bindings) do awful.keyboard.append_global_keybindings(v) end
