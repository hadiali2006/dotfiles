-- Theme handling library
local beautiful = require("beautiful")
-- Standard awesome library
local gears = require("gears")

beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/themes/custom/theme.lua")
--beautiful.useless_gap = 5
