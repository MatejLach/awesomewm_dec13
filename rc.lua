-- Matej Lach's awesome Awesome config :-)

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
vicious = require("vicious")
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/matejlach/.config/awesome/themes/mtlarch/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "emacs"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which will hold all screen tags.
 tags = {
	names  = { "term [1]", "web [2]", "edit [3]", "music [4]", "misc [5]", "mail [6]", "twitter [7]", "news [8]" },
	layout = { layouts[3], layouts[6], layouts[3], layouts[10], layouts[6], layouts[10], layouts[10], layouts[10] }}
	for s = 1, screen.count() do
		-- Each screen has its own tag table.
		tags[s] = awful.tag(tags.names, s, tags.layout)
	end
-- }}}
                                
-- {{{ Autostart
awful.util.spawn_with_shell("terminator -T term")
awful.util.spawn_with_shell("chromium")
awful.util.spawn_with_shell("emacs")
awful.util.spawn_with_shell(terminal .. " -T ncmpcpp-mpd -e ncmpcpp-wait")
awful.util.spawn_with_shell("geary")
awful.util.spawn_with_shell("hotot-launch")
awful.util.spawn_with_shell("liferea")
awful.util.spawn_with_shell("yapan")
awful.util.spawn_with_shell("redshift")
awful.util.spawn_with_shell("xbindkeys")
awful.util.spawn_with_shell("numlockx")
-- }}}

-- {{{ Menu
-- Create a laucher widget and a menu
appmenu = {
   { "firefox", "firefox" },
   { "midori", "midori" },
   { "geany", "geany" },
   { "gedit", "gedit" },
   { "codeblocks", "codeblocks" },
   { "aptana", "aptana" },
   { "idea", "idea.sh" },
   { "android-studio", "android-studio" },
   { "argouml", "argouml" },
   { "packettracer", "packettracer" },
   { "dart-editor", "dart-editor" },
   { "dia", "dia" },
   { "eagle", "eagle" },
   { "calibre", "calibre" },
   { "filezilla", "filezilla" },
   { "g-commander", "gnome-commander" },
   { "gsysmon", "gnome-system-monitor" },
   { "goldendict", "goldendict" },
   { "musicmanager", "google-musicmanager" },
   { "handbrake", "ghb" },
   { "sound-juicer", "sound-juicer" },
   { "keepassx", "keepassx" },
   { "truecrypt", "truecrypt" },
   { "minecraft", "minecraft" },
   { "nvidia-settings", "nvidia-xconfig" },
   { "virtualbox", "virtualbox" },
   { "pidgin", "pidgin" },
   { "poedit", "poedit" },
   { "bitmessage", "pybitmessage" },
   { "pycharm", "pycharm" },
   { "scilab", "scilab" },
   { "seamonkey", "seamonkey" },
   { "shotwell", "shotwell" },
   { "texstudio", "texstudio" },
   { "urbanterror", "urbanterror" },
   { "vlc", "vlc" },
   { "wireshark", "wireshark" },
   { "wxhexeditor", "wxHexEditor" },
   { "tor-browser", "tor-browser-en" },
   { "retext", "retext" },
   { "libreoffice", "libreoffice" },
   { "evince", "evince" },
   { "gimp", "gimp" },
   { "ario", "ario" },
   { "spotify", "spotify" },
   { "electrum", "electrum" },
   { "vlc", "vlc" },
   { "steam", "steam" },
   { "hotot", "hotot-gtk3" },
   { "reditr", "reditr" },
   { "liferea", "liferea" },
   { "vuze", "vuze" },
   { "rtorrent", "terminator -e rtorrent" },
   { "binreader", "binreader" },
   { "irc", "hexchat"}
}

myawesomemenu = {
   { "manual", "terminator -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { 	  { "apps", appmenu },
				                          { "awesome", myawesomemenu, beautiful.awesome_icon },
							  { "terminal", terminal },
								    { "web browser", "chromium" },
								    { "file manager", "thunar" },
								    { "mail", "geary" },
								    { "emacs", editor },
								    { "musictube", "musictube" },
								    { "ncmpcpp", terminal .. " -e ncmpcpp" },
                                    { "reboot", terminal .. " -e reboot" },
                                    { "shutdown", terminal .. " -e 'shutdown -h now'" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox

-- {{{ Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "gb |", "gb" }, { "sk |", "sk" } }
kbdcfg.current = 1  -- gb is the default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][1] .. " ")
kbdcfg.switch = function ()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_text(" " .. t[1] .. " ")
  os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

-- {{{ Mouse bindings
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)
-- }}}

-- {{{ CPU widget                                         
         local cpuwidget = wibox.widget.textbox()                               
         vicious.register(cpuwidget, vicious.widgets.cpu, "CPU: $1%")                
-- }}}

-- {{{ CPU temperature
        local thermalwidget  = wibox.widget.textbox()
        vicious.register(thermalwidget, vicious.widgets.thermal, " - $1°C", 5, { "coretemp.0", "core"} )
-- }}}

--{{{ Memory usage
      local memwidget = wibox.widget.textbox()
      vicious.register(memwidget, vicious.widgets.mem, " | RAM: $1% - ($2M/$3M)", 5)
-- }}}

-- Clock
mytextclock = awful.widget.textclock(" %H:%M:%S", 1)

-- Calendar
require('calendar2')
--}}}

-- BEGIN OF AWESOMPD WIDGET DECLARATION
-- 'mpc' needs to be installed for this to work
  local awesompd = require("awesompd/awesompd")
  musicwidget = awesompd:create() -- Create awesompd widget
  musicwidget.font = "Source Sans Pro" -- Set widget font 
  musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
  musicwidget.output_size = 15 -- Set the size of widget in symbols
  musicwidget.update_interval = 5 -- Set the update interval in seconds
  -- Specify decorators on the left and the right side of the
  -- widget. Or just leave empty strings if you decorate the widget
  -- from outside.
  musicwidget.ldecorator = " "
  musicwidget.rdecorator = " "
  -- Set all the servers to work with (here can be any servers you use)
  musicwidget.servers = {
     { server = "localhost",
          port = 6600 },
     --{ server = "192.168.0.72",
          --port = 6600 } 
        }
  -- Set the buttons of the widget
  musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
                     { "Control", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
               { "Control", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
               { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
               { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
               { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
                                 { "", "XF86AudioLowerVolume", musicwidget:command_volume_down() },
                                 { "", "XF86AudioRaiseVolume", musicwidget:command_volume_up() },
                                 { modkey, "Pause", musicwidget:command_playpause() } })
  musicwidget:run() -- After all configuration is done, run the widget

-- END OF AWESOMPD WIDGET DECLARATION

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

	-- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(musicwidget.widget)
    right_layout:add(kbdcfg.widget)
    right_layout:add(cpuwidget)
    right_layout:add(thermalwidget)
    right_layout:add(memwidget)
    right_layout:add(mytextclock)
    calendar2.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")
    right_layout:add(mylauncher)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end 
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    
    -- Custom Shortcuts
    awful.key({ modkey, "Shift"   }, "t", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "w", function () awful.util.spawn("chromium") end),
    awful.key({ modkey, "Shift"   }, "p", function () awful.util.spawn("proxium") end),
    awful.key({ modkey, "Shift"   }, "e", function () awful.util.spawn(editor) end),
    awful.key({ modkey, "Shift"   }, "f", function () awful.util.spawn("thunar") end),
    awful.key({ modkey, "Shift"   }, "m", function () awful.util.spawn(terminal .. " -e ncmpcpp") end),
    
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } }, 
                     
    -- Set terminator to always map on screen 1/tag 1.
    { rule = { name = "term" },
      properties = { tag = tags[1][1], switchtotag = true }
    },
    -- Set Chromium to always map on screen 1/tag 2.
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][2] } },
    -- Set Emacs to always map on screen 1/tag 3.
    { rule = { class = "Emacs" },
      properties = { tag = tags[1][3] } },
    -- Set ncmpcpp to always map on screen 1/tag 4.
    { rule = { name = "ncmpcpp-mpd" },
      properties = { tag = tags[1][4], switchtotag = true }
    },
    -- Set Geary to always map on screen 1/tag 6.
    { rule = { class = "Geary" },
      properties = { tag = tags[1][6] } },
    -- Set Hotot to always map on screen 1/tag 7.
    { rule = { class = "Hotot-gtk3" },
      properties = { tag = tags[1][7] } },
    -- Set Liferea to always map on screen 1/tag 8.
    { rule = { class = "Liferea" },
      properties = { tag = tags[1][8] } },
 -- The WM_CLASS property can be found using the 'xorg-xprop' utility. --
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
