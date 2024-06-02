local require = require
local capi = { client = client }
local awful = require("awful")
local mod = require("binds.mod")
return {
    awful.key(
        { mod.super, mod.shift },
        "Left",
        awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),
    awful.key(
        { mod.super, mod.shift },
        "Right",
        awful.tag.viewnext,
        { description = "view next", group = "tag" }
    ),
    awful.key(
        { mod.super },
        "Escape",
        awful.tag.history.restore,
        { description = "go back", group = "tag" }
    ),
    awful.key({
        modifiers   = { mod.super },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then tag:view_only() end
        end
    }),
    awful.key({
        modifiers   = { mod.super, mod.ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then awful.tag.viewtoggle(tag) end
        end
    }),
    awful.key({
        modifiers   = { mod.super, mod.shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if capi.client.focus then
                local tag = capi.client.focus.screen.tags[index]
                if tag then capi.client.focus:move_to_tag(tag) end
            end
        end
    }),
    awful.key({
        modifiers   = { mod.super, mod.ctrl, mod.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if capi.client.focus then
                local tag = capi.client.focus.screen.tags[index]
                if tag then capi.client.focus:toggle_tag(tag) end
            end
        end
    }),
    awful.key({
        modifiers   = { mod.super },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end
    })
}
