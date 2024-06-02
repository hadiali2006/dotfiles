local require = require
local awful = require("awful")
local mod = require("binds.mod")
return {
    awful.key({ mod.super, mod.shift }, "j",
        function()
            awful.client.swap.byidx(1)
        end,
        { description = "swap with next client by index", group = "client" }
    ),
    awful.key({ mod.super, mod.shift }, "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        { description = "swap with previous client by index", group = "client" }
    ),
    awful.key({ mod.super, },
        "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),
    awful.key({ mod.super, }, "l",
        function()
            awful.tag.incmwfact(0.01)
        end,
        { description = "increase master width factor (l)", group = "layout" }
    ),
    awful.key({ mod.super, }, "h",
        function()
            awful.tag.incmwfact(-0.01)
        end,
        { description = "decrease master width factor (h)", group = "layout" }
    ),

    awful.key({ mod.super, }, "Right",
        function()
            awful.tag.incmwfact(0.01)
        end,
        { description = "increase master with factor (right arrow)", group = "layout" }
    ),
    awful.key({ mod.super, }, "Left",
        function()
            awful.tag.incmwfact(-0.01)
        end,
        { description = "decrease master width factor (left arrow)", group = "layout" }
    ),
    awful.key({ mod.super, }, "Up",
        function()
            awful.client.incwfact(0.05)
        end,
        { description = "increase client width factor", group = "layout" }
    ),
    awful.key({ mod.super, }, "Down",
        function()
            awful.client.incwfact(-0.05)
        end,
        { description = "decrease client width factor", group = "layout" }
    ),
    awful.key({ mod.super, mod.shift }, "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        { description = "increase the number of master clients", group = "layout" }
    ),
    awful.key({ mod.super, mod.shift }, "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        { description = "decrease the number of master clients", group = "layout" }
    ),
    awful.key({ mod.super, mod.ctrl }, "h",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        { description = "increase the number of columns", group = "layout" }
    ),
    awful.key({ mod.super, mod.ctrl }, "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        { description = "decrease the number of columns", group = "layout" }
    ),
    awful.key({ mod.super, }, "space",
        function()
            awful.layout.inc(1)
        end,
        { description = "select next", group = "layout" }
    ),
    awful.key({ mod.super, mod.shift }, "space",
        function()
            awful.layout.inc(-1)
        end,
        { description = "select previous", group = "layout" }
    ),
}
