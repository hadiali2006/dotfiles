-- Add a titlebar if titlebars_enabled is set to true for the client in `config/rules.lua`.
client.connect_signal('request::titlebars', function(c)
   if c.requests_no_titlebars then return end
   require('ui.titlebar').normal(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
   c:activate({ context = 'mouse_enter', raise = false })
end)


--client.connect_signal('request::border', function(c) end)
