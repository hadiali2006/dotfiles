local awful = require("awful")
local ruled = require("ruled")
ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule({
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            -- placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            placement = function(c)
                if c.floating and c.transient_for ~= nil then
                    awful.placement.centered(c, { parent = c.transient_for })
                else
                    awful.placement.centered(c)
                end
            end,
            callback  = awful.client.setslave,
        }
    })
    -- Floating clients.
    ruled.client.append_rule({
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Gpick", "Nsxiv", "Tor Browser", "libreoffice",
            },
            --  NOTE: The name property shown in xprop might be set slightly after creation
            --  of the client and the name shown there might not match defined rules here.
            name    = {
                "Event Tester"   -- xev.
            },
            role    = {
                "AlarmWindow",   -- Thunderbird"s calendar.
                "ConfigManager", -- Thunderbird"s about:config.
                "pop-up"         -- e.g. Google Chrome"s (detached) Developer Tools.
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        }
    })

    ruled.client.append_rule({
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false }
    })
end)
