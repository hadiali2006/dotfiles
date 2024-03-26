local apps = {}
apps.terminal   = "alacritty"
apps.browser    = "firefox"
apps.editor     = os.getenv("EDITOR") or "nvim" or "neovim"
apps.editor_cmd = apps.terminal .. " -e " .. apps.editor

require("menubar").utils.terminal = apps.terminal

return apps
