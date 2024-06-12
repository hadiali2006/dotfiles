local require = require
local wezterm = require("wezterm")
local keys = require("keys")
local colors = require("colors")
-- local config = wezterm.config_builder()
local config = keys
config.switch_to_last_active_tab_when_closing_tab = true
-- config.hide_tab_bar_if_only_one_tab = true

config.leader = { key = "RightAlt", mods = "ALT", timeout_milliseconds = 1000 }

config.max_fps = 144

config.font = wezterm.font({
    family = "JetBrains Mono",
    harfbuzz_features = {
        "calt=0",
        "clig=0",
        "liga=0",
    },
})
config.font_size = 14.5
config.window_padding = {
    left = "2cell",
    right = "2cell",
    top = "0.5cell",
    bottom = 0,
}
config.front_end = "OpenGL"
config.line_height = 1.25
-- config.freetype_load_target = "VerticalLcd"

config.adjust_window_size_when_changing_font_size = false
config.use_fancy_tab_bar = false

config.colors = {
    foreground = colors.fg,
    background = colors.bg,
    cursor_bg = colors.fg,
    cursor_fg = colors.bg,
    cursor_border = colors.bg,
    selection_bg = colors.bright.black,
    selection_fg = colors.fg,
    ansi = {
        colors.bright.black,
        colors.bright.red,
        colors.bright.green,
        colors.bright.yellow,
        colors.bright.blue,
        colors.bright.magenta,
        colors.bright.cyan,
        colors.bright.white,
    },
    brights = {
        colors.regular.black,
        colors.regular.red,
        colors.regular.green,
        colors.regular.yellow,
        colors.regular.blue,
        colors.regular.magenta,
        colors.regular.cyan,
        colors.regular.white,
    },
    tab_bar = {
        background = "#090909",
        active_tab = {
            bg_color = colors.bg,
            fg_color = colors.fg,
        },
        inactive_tab = {
            bg_color = "#292929",
            fg_color = "#6f6f6f",
        },
        new_tab = {
            bg_color = "#333333",
            fg_color = "#6f6f6f",
        },
    },
}

-- wezterm.on("bell", function()
--     wezterm.background_child_process({ "bell" })
-- end)

return config
