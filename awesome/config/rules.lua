local awful = require("awful")
local ruled = require("ruled")

make_only_on_screen = function(c)
    -- get current screen
    local s = awful.screen.focused()
    -- make sure unminimized
    c.minimized = false
    -- minimize everything else local numminimized = 0
    for _,t in pairs(s.selected_tags) do
        for _,o in pairs(t:clients()) do
            -- skip the client in question
            if (o ~= c) and not (o.sticky) and not (o.ontop) then
                -- check if showing
                if (o:isvisible()) then
                    o.minimized = true
                    -- numminimized = numminimized + 1
                end
            end
        end
    end
    -- activate client
    c:emit_signal("request::activate", "tasklist", { raise = true } )
    -- return numminimized
end

local unminimize_all_peers = function(c)
    local s = c.screen
    for _, t in pairs(s.selected_tags) do
        for _, o in pairs(t:clients()) do
            o.minimized = false
        end
    end
end

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule({
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = function(c)
                if c.floating and c.transient_for ~= nil then
                    awful.placement.centered(c, { parent = c.transient_for })
                else
                    awful.placement.centered(c)
                end
            end,
            callback  = function (c)
                if (awful.layout.get(c.screen) == awful.layout.suit.max) then
                    make_only_on_screen(c)
                else
                    c:to_secondary_section()
                end
            end
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
