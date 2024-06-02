local os, require = os, require
local gears = require("gears")
local apps = {}
apps.terminal = "alacritty"
apps.browser = "firefox"
apps.editor = os.getenv("EDITOR") or "nvim"
apps.editor_cmd = apps.terminal .. " -e " .. apps.editor
require("menubar").utils.terminal = apps.terminal
local autostart_programs = {
    "unclutter",
    "picom --config "
        .. gears.filesystem.get_configuration_dir()
        .. "assets/picom.conf",
}
require("module.autostart")(autostart_programs)
return apps
