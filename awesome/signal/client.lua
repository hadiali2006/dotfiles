local awful = require("awful")

client.connect_signal("request::titlebars", function(c)
    if c.requests_no_titlebars then
        return
    end

    require("ui.titlebar").normal(c)
end)

--sloppy focus
client.connect_signal("mouse::enter", function (c)
    c:activate({ context = "mouse_enter", raise = false })
end)

--already done in rules but this will center popup windows with respect to their orgin
-- client.connect_signal("manage", function (c)
--     if c.floating then
--         if c.transient_for == nil then
--             awful.placement.centered(c)
--         else
--             awful.placement.centered(c, {parent = c.transient_for})
--         end
--         awful.placement.no_offscreen(c)
--     end
-- end)
