local capi = { client = client }

capi.client.connect_signal("request::titlebars", function(client)
    if client.requests_no_titlebars then return end
    require("ui.titlebar").normal(client)
end)

capi.client.connect_signal("mouse::enter", function(client)
    client:activate({ context = "mouse_enter", raise = false })
end)
