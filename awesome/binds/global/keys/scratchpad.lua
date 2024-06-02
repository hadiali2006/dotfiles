local require = require
local awful = require("awful")
local mod = require("binds.mod")
local scratchpad_group = require("config.scratchpads")
local scratchpads = scratchpad_group.scratchpads

return {
    awful.key({ mod.super }, "w", function()
        require("module.swallow").toggle()
    end),
    awful.key({ mod.super }, "F1", function()
        scratchpads[1]:toggle()
        -- scratchpads.F1_pad:toggle()
    end),
    awful.key({ mod.super }, "F2", function()
        scratchpads[2]:toggle()
        -- scratchpads.F2_pad:toggle()
    end),
    awful.key({ mod.super }, "F3", function()
        scratchpads2.scratchpad:toggle_visibility()
        scratchpads[3]:toggle()
        -- scratchpads.F3_pad:toggle()
    end),
    awful.key({ mod.super }, "F4", function()
        scratchpads[4]:toggle()
        -- scratchpads.F4_pad:toggle()
    end),
}
