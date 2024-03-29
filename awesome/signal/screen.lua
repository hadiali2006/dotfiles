local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")

local naughty = require("naughty")

-- Function to create and show a notification
local function notif(title, message)
    naughty.notify({
        title = title,
        text = message,
        timeout = 5,  -- Timeout in seconds
        position = "top_right"  -- Position of the notification
    })
end

local ui_module = require("ui")

-- Attach tags and widgets to all screens.
screen.connect_signal("request::desktop_decoration", function(s)
    -- Create all tags and attach the layouts to each of them.
    awful.tag(require("config.user").tags, s, awful.layout.layouts[1])
    -- Attach a wibar to each screen.
    ui_module.wibar(s)
end)

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper({
        screen = s,
        widget = wibox.widget {
            widget                = wibox.widget.imagebox,
            image = gears.surface.crop_surface({
                surface = gears.surface.load_uncached(beautiful.wallpaper),
                ratio = s.geometry.width/s.geometry.height
            })
        }
    })
end)

--Remove borders if there is one window one the screen or if the layout is set to max.
screen.connect_signal("arrange", function(s)
    for _, client in pairs(s.clients) do
        local client_is_max = client.maximized
        local layout_is_max = client.screen.selected_tag.layout.name == "max"
        local one_client_on_screen = #s.clients == 1
        if layout_is_max or one_client_on_screen or (client_is_max and not one_client_on_screen) then
            client.border_width = 0
        else
            client.border_width = beautiful.border_width
        end
    end
end)
