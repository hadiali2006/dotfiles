local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "theme/"

local theme = {}

theme.font          = "Jetbrains Mono Nerd Font Regular 13"
-- theme.font          = "cozette 10"

local opacity_append = "aa"
theme.bg_normal     = "#111114" .. opacity_append
theme.bg_focus      = "#111114"
-- theme.bg_focus      = "#31363b"

theme.bg_urgent     = "#750800"
theme.bg_minimize   = "#444444" .. opacity_append
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap         = dpi(5)
theme.border_width        = dpi(2)
-- theme.border_color_normal = "#000000"
--theme.border_color_active = "#535d6c"
theme.border_color_normal = "#00000000"
theme.border_color_active = "#535d6c00"
theme.border_color_marked = "#91231c"


theme.snap_bg = "#ffffff"
theme.snap_border_width = 3
theme.snap_shape = gears.shape.rectangle

-- There are other variable sets
-- overriding the custom one when
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
local taglist_square_size = dpi(5)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."submenu.png"
theme.menu_height = dpi(21)
theme.menu_width  = dpi(180)

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
theme.wallpaper = themes_path.. "wallpapers" .. require("theme.wallpaper")

-- You can use your own layout icons like this:
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
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
    rnotification.append_rule {
        rule       = { urgency = "critical" },
        properties = { bg = "#ff0000", fg = "#ffffff" }
    }
end)

local colors_2 = {

    bg         = "#17181C",
    mid_bg     = "#1E1F24",
    light_bg   = "#26272B",
    dark_grey  = "#333438",
    light_grey = "#8F9093",
    dark_fg    = "#B0B1B4",
    mid_fg     = "#CBCCCE",
    fg         = "#E4E5E7",
    pink       = "#FA3867",
    orange     = "#F3872F",
    gold       = "#FEBD16",
    lime       = "#3FD43B",
    turquoise  = "#47E7CE",
    blue       = "#53ADE1",
    violet     = "#AD60FF",
    red        = "#FC3F2C",
    -- ansi = {
    --     "#17181C",
    --     "#FA3867",
    --     "#3FD43B",
    --     "#FEBD16",
    --     "#53ADE1",
    --     "#AD60FF",
    --     "#47E7CE",
    --     "#B0B1B4"
    -- },
    -- brights = {
    --     "#26272B",
    --     "#FA3867",
    --     "#3FD43B",
    --     "#FEBD16",
    --     "#53ADE1",
    --     "#AD60FF",
    --     "#47E7CE",
    --     "#E4E5E7"
    -- }
}

local colors = {
    bright = {
        -- black   = "#7f8c8d",
        black   = "#17181C",
        blue    = "#3daee9",
        cyan    = "#16a085",
        green   = "#1cdc9a",
        magenta = "#8e44ad",
        red     = "#c0392b",
        white   = "#ffffff",
        yellow  = "#fdbc4b",
    },
    normal = {
        black   = "#232627",
        blue    = "#1d99f3",
        cyan    = "#1abc9c",
        green   = "#11d116",
        magenta = "#9b59b6",
        red     = "#ed1515",
        white   = "#fcfcfc",
        yellow  = "#f67400",
    },
    dim    = {
        black   = "#31363b",
        blue    = "#1b668f",
        cyan    = "#186c60",
        green   = "#17a262",
        magenta = "#614a73",
        red     = "#783228",
        white   = "#63686d",
        yellow  = "#b65619",
    },
}

theme.MAX_ALPHA = 65535
theme.modules = {}

theme.modules.date = {
    widget = {
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 1,
        },
    },
    icon = {
        calendar_svg = themes_path .. "icons/calendar.svg",
        calendar = " 󰃭 ",
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 2,
        },
    },
    popup = {
        border_color = colors.bright.white,
        border_width  = 1,
    },
}

theme.modules.time = {
    widget = {
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 1,
        },
    },
    icon = {
        clock_svg = themes_path .. "icons/clock.svg",
        clock = "  ",
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 2,
        },
    }
}

theme.modules.volume = {
    widget = {
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 1,
        },
    },
    icon = {
        volume_svg = themes_path .. "icons/volume_2.svg",
        muted_svg = themes_path .. "icons/muted_2.svg",
        volume  = " 󰕾 ",
        mute    = " 󰖁 ",
        percent = "%",
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.red,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.red,
            border_color = colors.bright.white,
            border_width  = 2,
        },
    }
}

theme.modules.ddcutil = {
    widget = {
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 1,
        },
    },
    icon = {
        brightness_svg = themes_path .. "icons/ddcutil_brightness_3.svg",
        brightness = " 󰛩 ",
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 2,
        },
    }
}

theme.modules.redshift = {
    widget = {
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 1,
        },
    },
    icon = {
        temperature = "  ",
        daytime     = "  ",
        night       = "  ",
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 2,
        },
    }
}

theme.modules.systray = {
    widget = {
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 1,
        },
    },
    icon = {
        menu_svg = themes_path .. "icons/menu.svg",
        markup = {
            background = colors.bright.black,
            foreground = colors.bright.white,
            alpha      = theme.MAX_ALPHA,
        },
        background_container = {
            background   = colors.bright.black,
            foreground   = colors.bright.white,
            border_color = colors.bright.white,
            border_width  = 2,
        },
    },
    popup = {
        border_color = colors.bright.white,
        border_width  = 1,
    }
}

theme.modules.layoutbox = {
    background   = colors.bright.black,
    foreground   = colors.bright.white,
    border_color = colors.bright.white,
    border_width  = 1,
}

--
-- theme.widget = {}
-- theme.widget.icon = {}
-- theme.widget.bg_markup           = colors.bright.black
-- theme.widget.fg_markup           = colors.bright.white
-- theme.widget.alpha_markup        = 65535
--
-- theme.widget.bg_widget     = colors.bright.black
-- theme.widget.fg_widget     = colors.bright.white
-- theme.widget.border_widget = colors.bright.white
-- theme.widget.border_width   = 2
--
-- theme.widget.icon.bg_markup      = colors.bright.black
-- theme.widget.icon.fg_icon_markup = colors.bright.white
-- theme.widget.icon.alpha_markup   = 65535
--
-- theme.widget.icon.bg_widget     = colors.bright.black
-- theme.widget.icon.fg_widget     = colors.bright.white
-- theme.widget.icon.border_widget = colors.dim.black
-- theme.widget.icon.border_width   = 2
--
-- theme.widget.border_popup = colors.bright.white .. opacity_append

theme.systray_icon_spacing = 5

theme.thin_space = " "
    -- return " "
return theme
