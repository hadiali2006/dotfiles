local require = require
local awful = require("awful")
local mod = require("binds.mod")
local scratchpad_group = require("config.scratchpads")
local scratchpads = scratchpad_group.scratchpads
return {
    awful.key({ mod.super, mod.alt }, "F1", function(c)
        scratchpads[1]:set(c)
    end),
    awful.key({ mod.super, mod.alt }, "F2", function(c)
        scratchpads[2]:set(c)
    end),
    awful.key({ mod.super, mod.alt }, "F3", function(c)
        scratchpads[3]:set(c)
    end),
    awful.key({ mod.super, mod.alt }, "F4", function(c)
        scratchpads[4]:set(c)
    end),
}
