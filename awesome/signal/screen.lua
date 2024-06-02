local require = require
local capi = { screen = screen }
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local widgets = require("ui")

capi.screen.connect_signal("request::desktop_decoration", function(screen)
    awful.tag(require("config.user").tags, screen, awful.layout.layouts[1])
    widgets.wibar(screen)
end)

capi.screen.connect_signal("request::wallpaper", function(screen)
    awful.wallpaper({
        screen = screen,
        widget = wibox.widget {
            widget = wibox.widget.imagebox,
            image = gears.surface.crop_surface({
                surface = gears.surface.load_uncached(beautiful.wallpaper),
                ratio = screen.geometry.width / screen.geometry.height
            })
        }
    })
end)
