local require = require
local beautiful = require("beautiful")
local gears = require("gears")
local ruled = require("ruled")
local theme_assets = beautiful.theme_assets
local xresources = beautiful.xresources
local ruled_notification = ruled.notification
local dpi = xresources.apply_dpi

local themes_path = gears.filesystem.get_configuration_dir() .. "theme/"

local theme = {}

theme.wallpaper = themes_path .. "/wallpaper/1.png"

theme.fontt = "Jetbrains Mono Nerd Font Regular"
theme.font = "Jetbrains Mono Nerd Font Regular 13"

--262626
theme.bg_normal = "#161616"
theme.bg_focus = "#262626"
theme.bg_urgent = "#a2191f"
theme.bg_minimize = "#393939"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(5)
theme.border_width = dpi(2)
theme.border_color_normal = "#000000"
theme.border_color_active = "#ffffff"
theme.border_color_marked = "#a2191f"

theme.snap_bg = "#ffffff"
theme.snap_border_width = dpi(3)
theme.snap_shape = gears.shape.rectangle
theme.screenshot_frame_color = "#ffffff"
theme.screenshot_frame_shape = gears.shape.rectangle

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(21)
theme.menu_width = dpi(180)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path.."titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path.."titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path.."titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path.."titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path.."titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path.."titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path.."titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path.."titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path.."titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path.."titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path.."titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path.."titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path.."titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path.."titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path.."titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path.."titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path.."titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path.."titlebar/maximized_focus_active.png"

theme.layout_fairh      = themes_path.."layouts/fairhw.png"
theme.layout_fairv      = themes_path.."layouts/fairvw.png"
theme.layout_floating   = themes_path.."layouts/floatingw.png"
theme.layout_magnifier  = themes_path.."layouts/magnifierw.png"
theme.layout_max        = themes_path.."layouts/maxw.png"
theme.layout_fullscreen = themes_path.."layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."layouts/tileleftw.png"
theme.layout_tile       = themes_path.."layouts/tilew.png"
theme.layout_tiletop    = themes_path.."layouts/tiletopw.png"
theme.layout_spiral     = themes_path.."layouts/spiralw.png"
theme.layout_dwindle    = themes_path.."layouts/dwindlew.png"
theme.layout_cornernw   = themes_path.."layouts/cornernww.png"
theme.layout_cornerne   = themes_path.."layouts/cornernew.png"
theme.layout_cornersw   = themes_path.."layouts/cornersww.png"
theme.layout_cornerse   = themes_path.."layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
ruled_notification.connect_signal("request::rules", function()
    ruled_notification.append_rule({
        rule = { urgency = "critical" },
        properties = { bg = "#a2191f", fg = "#ffffff" },
    })
end)

theme.wibar_widget_margin = 5
theme.wibar_widget_bg = "#21272a"
theme.wibar_widget_fg = "#ffffff"
theme.wibar_widget_border_color = "#ffffff"
theme.wibar_widget_border_width = 1

theme.volume_icon_on = themes_path .. "icons/volume/volume.svg"
theme.volume_icon_off = themes_path .. "icons/volume/muted.svg"
theme.brightness_icon = themes_path .. "icons/ddcutil/brightness.svg"
theme.time_icon = themes_path .. "icons/clock/clock.svg"
theme.date_icon = themes_path .. "icons/calendar/calendar.svg"
theme.menu_icon = themes_path .. "icons/menu/menu2.svg"
theme.trash_icon = themes_path .. "icons/calendar/trash.svg"

return theme
