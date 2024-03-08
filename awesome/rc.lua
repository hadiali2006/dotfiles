-- awesome_mode: api-level=4:screen=on

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local naughty = require("naughty")
naughty.connect_signal("request::display_error", function(message, startup)
   naughty.notification({
      urgency = "critical",
      title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
      message = message
   })
end)

-- Allow Awesome to automatically focus a client upon changing tags or loading.
require("awful.autofocus")


--For other program hotkeys in hotkeys popup
require("awful.hotkeys_popup.keys")

require("theme")
require("signal")
require("binds")
require("config.rules")
require("module.autostart")
-- require("module.bling")
