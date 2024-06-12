local require = require
local capi = { client = client, }
local awful = require("awful")
local mod = require("binds.mod")
local modkey = mod.modkey

return function(screen)
    return awful.widget.taglist({
        screen = screen,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            -- Left-clicking a tag changes to it.
            awful.button(nil, 1, function(tag)
                tag:view_only()
            end),
            -- Mod + Left-clicking a tag sends the currently focused client to it.
            awful.button({ modkey }, 1, function(tag)
                if capi.client.focus then
                    capi.client.focus:move_to_tag(tag)
                end
            end),
            -- Right-clicking a tag makes its contents visible in the current one.
            awful.button(nil, 3, awful.tag.viewtoggle),
            -- Mod + Right-clicking a tag makes the currently focused client visible
            -- in it.
            awful.button({ modkey }, 3, function(tag)
                if capi.client.focus then
                    capi.client.focus:toggle_tag(tag)
                end
            end),
            -- Mousewheel scrolling cycles through tags.
            awful.button(nil, 4, function(tag)
                awful.tag.viewprev(tag.screen)
            end),
            awful.button(nil, 5, function(tag)
                awful.tag.viewnext(tag.screen)
            end),
        },
    })
end
