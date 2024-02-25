local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local widgets = require("ui")

--- Attach tags and widgets to all screens.
screen.connect_signal("request::desktop_decoration", function(s)
	-- Create all tags and attach the layouts to each of them.
	awful.tag(require("config.user").tags, s, awful.layout.layouts[1])
	-- Attach a wibar to each screen.
	widgets.wibar(s)
end)

--- Wallpaper.
-- NOTE: `awful.wallpaper` is ideal for creating a wallpaper IF YOU
-- BENEFIT FROM IT BEING A WIDGET and not just the root window
-- background. IF YOU JUST WISH TO SET THE ROOT WINDOW BACKGROUND, you
-- may want to use the deprecated `gears.wallpaper` instead. This is
-- the most common case of just wanting to set an image as wallpaper.
screen.connect_signal("request::wallpaper", function(s)
	awful.wallpaper({
		screen = s,
		widget = {
			widget = wibox.container.tile,
			valign = "center",
			halign = "center",
			tiled  = false,
			{
				widget    = wibox.widget.imagebox,
				image     = beautiful.wallpaper,
				upscale   = true,
				downscale = true,
			},
		},
	})
end)
-- An example of what's mentioned above. For more information, see:
-- https://awesomewm.org/apidoc/utility_libraries/gears.wallpaper.html
-- gears.wallpaper.maximized(beautiful.wallpaper)

--remove borders if there is one window one the screen or if the layout is set to max
screen.connect_signal("arrange", function(s)
	for _, client in pairs(s.clients) do
		local isScreenLayoutMax = client.screen.selected_tag.layout.name == "max"
		local oneClientOnScreen = #s.clients == 1
		if isScreenLayoutMax or oneClientOnScreen then
			client.border_width = 0
		else
			client.border_width = beautiful.border_width
		end
	end
end)
