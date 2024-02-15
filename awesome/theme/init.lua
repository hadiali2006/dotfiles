-- Theme handling library
local beautiful = require('beautiful')
-- Standard awesome library
local gears     = require('gears')

-- Themes define colors, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/default/theme.lua")

--beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/gtk/theme.lua")
--beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/sky/theme.lua")
--beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/xresources/theme.lua")
--beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/zenburn/theme.lua")

beautiful.useless_gap = 5
