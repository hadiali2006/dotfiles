local awful = require('awful')

local mod    = require('binds.mod')
local modkey = mod.modkey

--- Client keybindings.
client.connect_signal('request::default_keybindings', function()
   awful.keyboard.append_client_keybindings({
      -- Client state management.
      awful.key({ modkey,           }, 'f',
         function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
         end, { description = 'toggle fullscreen', group = 'client' }),
      awful.key({ modkey,           }, 'q', function(c) c:kill() end,
         { description = 'close', group = 'client' }),
      awful.key({ modkey, mod.ctrl  }, 'space', awful.client.floating.toggle,
         { description = 'toggle floating', group = 'client' }),
      awful.key({ modkey,           }, 'n',
         function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
         end, { description = 'minimize', group = 'client' }),
      awful.key({ modkey,           }, 'm',
         function(c)
            c.maximized = not c.maximized
            c:raise()
         end, { description = '(un)maximize', group = 'client' }),
      awful.key({ modkey, mod.ctrl  }, 'm',
         function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
         end, { description = '(un)maximize vertically', group = 'client' }),
      awful.key({ modkey, mod.shift }, 'm',
         function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
         end, { description = '(un)maximize horizontally', group = 'client' }),

      -- Client position in tiling management.
      awful.key({ modkey, mod.ctrl  }, 'Return', function(c) c:swap(awful.client.getmaster()) end,
         { description = 'move to master', group = 'client' }),
      awful.key({ modkey,           }, 'o', function(c) c:move_to_screen() end,
         { description = 'move to screen', group = 'client' }),
      awful.key({ modkey,           }, 't', function(c) c.ontop = not c.ontop end,
         { description = 'toggle keep on top', group = 'client' }),
    

  -- Resize windows
     awful.key({ modkey, "Control" }, "Up", function (c)
       if c.floating then
         c:relative_move( 0, 0, 0, -10)
       else
         awful.client.incwfact(0.025)
       end
     end,{description = "Floating Resize Vertical -", group = "client"}),
     awful.key({ modkey, "Control" }, "Down", function (c)
       if c.floating then
         c:relative_move( 0, 0, 0,  10)
       else
         awful.client.incwfact(-0.025)
       end
     end,{description = "Floating Resize Vertical +", group = "client"}),
     awful.key({ modkey, "Control" }, "Left", function (c)
       if c.floating then
         c:relative_move( 0, 0, -10, 0)
       else
         awful.tag.incmwfact(-0.025)
       end
     end,{description = "Floating Resize Horizontal -", group = "client"}),
     awful.key({ modkey, "Control" }, "Right", function (c)
       if c.floating then
         c:relative_move( 0, 0,  10, 0)
       else
         awful.tag.incmwfact(0.025)
       end
     end,{description = "Floating Resize Horizontal +", group = "client"}),
     
    --moving floating windows
    awful.key({ modkey, mod.alt    }, "Down", function (c)
       c:relative_move(  0,  10,   0,   0)
     end, {description = "Floating Move Down", group = "client"}),
     awful.key({ modkey, mod.alt   }, "Up", function (c)
       c:relative_move(  0, -10,   0,   0)
     end, {description = "Floating Move Up", group = "client"}),
     awful.key({ modkey, mod.alt   }, "Left", function (c)
       c:relative_move(-10,   0,   0,   0)
     end, {description = "Floating Move Left", group = "client"}),
     awful.key({ modkey, mod.alt   }, "Right", function (c)
       c:relative_move( 10,   0,   0,   0)
     end, {description = "Floating Move Right", group = "client"}),

     -- Moving window focus works between desktops
     awful.key({ modkey, mod.alt   }, "j", function (c)
       awful.client.focus.global_bydirection("down")
       c:lower()
     end,
     {description = "focus next window up", group = "client"}),
     awful.key({ modkey, mod.alt   }, "k", function (c)
       awful.client.focus.global_bydirection("up")
       c:lower()
     end,
     {description = "focus next window down", group = "client"}),
     awful.key({ modkey, mod.alt   }, "l", function (c)
       awful.client.focus.global_bydirection("right")
       c:lower()
     end,
     {description = "focus next window right", group = "client"}),
     awful.key({ modkey, mod.alt   }, "h", function (c)
       awful.client.focus.global_bydirection("left")
       c:lower()
     end,
     {description = "focus next window left", group = "client"}),

-- Moving windows between positions works between desktops
     awful.key({ modkey, mod.alt, mod.ctrl}, "h", function (c)
       awful.client.swap.global_bydirection("left")
       c:raise()
     end,
     {description = "swap with left client", group = "client"}),
     awful.key({ modkey, mod.alt, mod.ctrl}, "l", function (c)
       awful.client.swap.global_bydirection("right")
       c:raise()
     end,
     {description = "swap with right client", group = "client"}),
     awful.key({ modkey, mod.alt, mod.ctrl}, "j", function (c)
       awful.client.swap.global_bydirection("down")
       c:raise()
     end,
     {description = "swap with down client", group = "client"}),
     awful.key({ modkey, mod.alt, mod.ctrl}, "k", function (c)
       awful.client.swap.global_bydirection("up")
       c:raise()
     end,
     {description = "swap with up client", group = "client"})

   })
end)
