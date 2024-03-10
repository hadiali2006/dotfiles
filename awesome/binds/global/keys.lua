local naughty = require("naughty")

-- Function to create and show a notification
local function notif(title, message)
    naughty.notify({
        title = title,
        text = message,
        timeout = 1,
        position = "top_right"  -- Position of the notification
    })
end

local awful    = require("awful")

local mod      = require("binds.mod")
local modkey   = mod.modkey

local apps     = require("config.apps")
local widgets  = require("ui")

local gapTable = { 0, 5 }
local gapIndex = 1

awful.keyboard.append_global_keybindings({
    -- General Awesome keys.
    awful.key({ mod.modkey, mod.alt}, "End", function ()
        awful.spawn.with_shell("systemctl suspend")
    end),
    awful.key({ mod.modkey, }, "z", function ()
        awful.spawn.with_shell("rofi -show drun")
    end),
    awful.key({ mod.modkey, }, "a", function ()
        awful.spawn.with_shell("firefox")
    end),
    awful.key({ nil, }, "XF86AudioPlay", function ()
        awful.spawn.with_shell("playerctl play-pause")
    end),
    awful.key({ nil, }, "XF86AudioNext", function ()
        awful.spawn.with_shell("playerctl next")
    end),
    awful.key({ nil, }, "XF86AudioPrev", function ()
        awful.spawn.with_shell("playerctl previous")
    end),
    awful.key({ nil, }, "XF86AudioRaiseVolume", function ()
        awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
        awful.spawn.with_shell("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+")
        -- notif("bind raise")
        awesome.emit_signal("volume::increase", "inc", 1)
    end),
    awful.key({ nil, }, "XF86AudioLowerVolume", function ()
        awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
        awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-")
        -- notif("bind lower")
        awesome.emit_signal("volume::decrease", "dec", 1)
    end),
    awful.key({ nil, mod.ctrl }, "XF86AudioRaiseVolume", function ()
        awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
        awful.spawn.with_shell("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+")
        awesome.emit_signal("volume::increase", "inc", 5)
    end),
    awful.key({ nil, mod.ctrl }, "XF86AudioLowerVolume", function ()
        awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
        awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
        awesome.emit_signal("volume::decrease", "dec", 5)
    end),
    awful.key({ nil, }, "XF86AudioMute", function ()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
        awesome.emit_signal("volume::togglemute")
    end),

    awful.key({ nil, mod.ctrl }, "XF86AudioMute", function ()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
        awesome.emit_signal("volume::togglemute")
    end),

    awful.key({ modkey, }, "o", function()
        require("beautiful").useless_gap = gapTable[gapIndex]
        if gapIndex < 2 then
            gapIndex = gapIndex + 1
        else
            gapIndex = 1
        end
        awful.screen.connect_for_each_screen(function(s)
            awful.layout.arrange(s)
        end)
    end),
    awful.key({ modkey, }, "s", require("awful.hotkeys_popup").show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, mod.shift }, "w", function() widgets.menu.main:show() end,
        { description = "show main menu", group = "awesome" }),
    awful.key({ modkey, mod.ctrl }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, mod.shift }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, mod.shift }, "x", function()
        awful.prompt.run({
            prompt       = "Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        })
    end, { description = "lua execute prompt", group = "awesome" }),
    awful.key({ modkey, }, "Return", function() awful.spawn(apps.terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "p", function() require("menubar").show() end,
        { description = "show the menubar", group = "launcher" }),

    -- Tags related keybindings.
    awful.key({ modkey, mod.shift }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, mod.shift }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    -- Focus related keybindings.
    awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),
    awful.key({ modkey, }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = "go back", group = "client" }),
    awful.key({ modkey, mod.ctrl }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, mod.ctrl }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, mod.ctrl }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate { raise = true, context = "key.unminimize" }
        end
    end, { description = "restore minimized", group = "client" }),

    -- Layout related keybindings.
    awful.key({ modkey, mod.shift }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, mod.shift }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.01) end,
        { description = "increase master width factor (l)", group = "layout" }),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.01) end,
        { description = "decrease master width factor (h)", group = "layout" }),

    awful.key({ modkey, }, "Right", function() awful.tag.incmwfact(0.01) end,
        { description = "increase master with factor (right arrow)", group = "layout" }),
    awful.key({ modkey, }, "Left", function() awful.tag.incmwfact(-0.01) end,
        { description = "decrease master width factor (left arrow)", group = "layout" }),
    awful.key({ modkey, }, "Up", function() awful.client.incwfact(0.05) end,
        { description = "increase client width factor", group = "layout" }),
    awful.key({ modkey, }, "Down", function() awful.client.incwfact(-0.05) end,
        { description = "decrease client width factor", group = "layout" }),


    awful.key({ modkey, mod.shift }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, mod.shift }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, mod.ctrl }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, mod.ctrl }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, mod.shift }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),
    awful.key({
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then tag:view_only() end
        end
    }),
    awful.key({
        modifiers   = { modkey, mod.ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then awful.tag.viewtoggle(tag) end
        end
    }),
    awful.key({
        modifiers   = { modkey, mod.shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:move_to_tag(tag) end
            end
        end
    }),
    awful.key({
        modifiers   = { modkey, mod.ctrl, mod.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:toggle_tag(tag) end
            end
        end
    }),
    awful.key({
        modifiers   = { modkey },
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
})
