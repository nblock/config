-- {{{ License
-- rc.lua, works with awesome 3.4.9 (Arch Linux)
-- author: nblock <nblock [at] archlinux.us>
-- based on multiple rc.lua files from different awesome users
--
-- This work is licensed under the Creative Commons Attribution Share
-- Alike License: http://creativecommons.org/licenses/by-sa/3.0/
-- }}}

-- {{{ Load libraries
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = "vim" 
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,		--1
    awful.layout.suit.tile.left,	--2
    awful.layout.suit.tile.bottom,	--3
    awful.layout.suit.tile.top,		--4
    awful.layout.suit.fair,		--5
    awful.layout.suit.fair.horizontal,	--6
    awful.layout.suit.spiral,		--7
    awful.layout.suit.spiral.dwindle,	--8
    awful.layout.suit.max,		--9
    awful.layout.suit.max.fullscreen,	--10
    awful.layout.suit.magnifier,	--11
    awful.layout.suit.floating		--12
}

-- some commands
local commands = {}
commands.suspend = "sudo pm-suspend"
commands.lock = "xlock -mode blank"
commands.screenshot = "scrot -e 'mv $f ~/bilder/screenshots'"
--audio stuff
commands.raisevol = "amixer set PCM 2%+"
commands.lowervol = "amixer set PCM 2%-"
commands.mute = "amixer sset PCM toggle"
commands.cmusnext = "cmus-remote --next"
commands.cmusprev = "cmus-remote --prev"
commands.cmuspause = "cmus-remote --pause"
commands.cmusplay = "cmus-remote --play"
commands.calc = "krunner"
--todo
commands.fileman = "pcmanfm"
commands.calc = "xcalc"
commands.browser = "firefox"
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 
     "1 download", "2 mail", "3 chat", 
     "4 music", "5 news", "6 web", 
     "7 fm", 8, 9 }, s,
    {layouts[3], layouts[1], layouts[1], -- Tags: 1, 2, 3
     layouts[1], layouts[1], layouts[1], --       4, 5 ,6
     layouts[1], layouts[1], layouts[1]  --       7, 8, 9
    })
 

end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- {{{ Widgets configuration
-- {{{ Reusable separators
local spacer         = widget({ type = "textbox", name = "spacer" })
local separator      = widget({ type = "textbox", name = "separator" })
spacer.text    = " "
separator.text = " <span foreground='red'>•</span> "
-- }}}


-- {{{ CPU load 
local cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, "<span foreground='orange'>load: </span><span foreground='green'>$2%</span><span foreground='orange'> - </span><span foreground='green'>$3%</span>")
-- }}}
 
-- {{{ CPU temperature
local thermalwidget  = widget({ type = "textbox" })
vicious.register(thermalwidget, vicious.widgets.thermal, "<span foreground='orange'>temp: </span><span foreground='green'>$1°C</span>", 20, "thermal_zone1")
-- }}}

-- {{{ Battery state
-- Widget icon
-- baticon       = widget({ type = "imagebox", name = "baticon" })
-- baticon.image = image(beautiful.widget_bat)
local batwidget     = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "<span foreground='orange'>bat: </span><span foreground='green'>$1$2%</span>", 60, "C1C5")
-- }}}

-- {{{ Date and time
local datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "<span foreground='green'>%a, %d.%m.%y - %H:%M</span>", 5)
-- }}}

-- {{{ Volume widget
local volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume, "<span foreground='orange'>vol: </span><span foreground='green'>$1%</span>", 1, 'PCM')
-- }}}

-- {{{ cmus widget
cmus = widget({ type = "textbox", name = "cmus" })
cmus.text = "<span foreground='orange'>cmus: </span><span foreground='green'>-</span>"
-- }}}

-- {{{ newsbeuter widget
newsbeuter = widget({ type = "textbox", name = "newsbeuter" })
newsbeuter.text = "<span foreground='orange'>newsbeuter: </span><span foreground='green'>-</span>"
-- }}}

-- {{{ System tray
systray = widget({ type = "systray" })
-- }}}
-- }}}

-- {{{ Wibox initialisation
local wibox     = {}
local promptbox = {}
local layoutbox = {}
local taglist   = {}
taglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev))

local tasklist = {}
tasklist.buttons = awful.util.table.join(
		awful.button({ }, 1,
			function(c)
				if not c:isvisible() then
					awful.tag.viewonly(c:tags()[1])
				end
				client.focus = c
				c:raise()
			end),
		 awful.button({ }, 3,
			function()
				if instance then
					instance:hide()
					instance = nil
				else
					instance = awful.menu.clients({ width = 250 })
				end
			end),
		 awful.button({ }, 4,
			function()
				awful.client.focus.byidx(1)
				if client.focus then
					client.focus:raise()
				end
			end),
		 awful.button({ }, 5,
			function()
				awful.client.focus.byidx(-1)
				if client.focus then
					client.focus:raise()
				end
		end)
)


for s = 1, screen.count() do
    -- Create a promptbox
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create a layoutbox
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
    ))

    -- Create a taglist widget
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)

    -- Create a tasklist widget
    tasklist[s] = awful.widget.tasklist(
	  	  function(c)
    		      return awful.widget.tasklist.label.currenttags(c, s)
		  end,
		  tasklist.buttons
    )

    -- Create the wibox
    wibox[s] = awful.wibox({
        position = "top", screen = s,
        fg = beautiful.fg_normal, bg = beautiful.bg_normal
    })
    -- Add widgets to the wibox
    wibox[s].widgets = {{
        launcher, taglist[s], layoutbox[s], promptbox[s],
        layout = awful.widget.layout.horizontal.leftright
    },
        s == screen.count() and systray or nil,
        spacer, datewidget,
	separator, volwidget,
        separator, batwidget,
        separator, cpuwidget,
        separator, thermalwidget,
        separator, newsbeuter,
        separator, cmus,
	separator, tasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
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
    --user defined
    awful.key({}, "XF86PowerOff", function() awful.util.spawn_with_shell(commands.suspend) end ),
    awful.key({ modkey,           }, "F12",   function () awful.util.spawn_with_shell(commands.lock) end),
    --audio stuff
    awful.key({}, "XF86AudioMute", function() awful.util.spawn_with_shell(commands.mute) end ),
    awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn_with_shell(commands.raisevol) end ),
    awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn_with_shell(commands.lowervol) end ),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn_with_shell(commands.cmusnext) end ),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn_with_shell(commands.cmusprev) end ),
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn_with_shell(commands.cmuspause) end ),
    awful.key({}, "XF86Tools", function() awful.util.spawn_with_shell(commands.cmusplay) end ),
    awful.key({}, "XF86Calculator", function() awful.util.spawn_with_shell(commands.calc) end ),
    awful.key({}, "Print", function() awful.util.spawn_with_shell(commands.screenshot) end ),

   -- awful.key({}, "XF86MyComputer", function() awful.util.spawn_with_shell(commands.fileman) end ),
   -- awful.key({}, "XF86Mail", function() awful.util.spawn_with_shell(commands.mail) end ),
   -- awful.key({}, "XF86HomePage", function() awful.util.spawn_with_shell(commands.browser) end ),
   -- awful.key({}, "XF86Sleep", function() awful.util.spawn_with_shell(commands.lock) end ),
   -- awful.key({"Control", "Mod1"}, "l", function() awful.util.spawn_with_shell(commands.lock) end ),

    --default bindings
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "n",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "n", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "n", function () awful.screen.focus_relative( 1) end),
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

    -- Prompt
    awful.key({ modkey },            "r",     function () promptbox[mouse.screen]:run() end),
    -- Run stuff in a Terminal
    awful.key({ modkey }, "x", function ()
     awful.prompt.run({ prompt = "Run in Terminal: " }, promptbox[mouse.screen].widget,
     function (prog)
      awful.util.spawn_with_shell(terminal .. " -name " .. prog .. " -e /bin/zsh -c " .. prog)
     end)
    end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "j",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
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
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    --floating apps
    { rule = { class = "pinentry-qt4" },
    properties = { floating = true } },
    { rule = { class = "pinentry-gtk-2" },
    properties = { floating = true } },
    { rule = { class = "Gimp" },
    properties = { floating = true } },
    --apptags
    --downloading stuff
    { rule = { class = "JDownloader" },
    properties = { tag = tags[1][1],switchtotag = false } },
    { rule = { instance = "rtorrent" },
    properties = { tag = tags[1][1],switchtotag = false } },
    -- mail
    { rule = { class = "Thunderbird" },
    properties = { tag = tags[1][2],switchtotag = true } },
    --chat and stuff like that
    { rule = { class = "Choqok" },
    properties = { tag = tags[1][3],switchtotag = false } },
    { rule = { class = "Kopete" },
    properties = { tag = tags[1][3],switchtotag = false } },
    -- cmus
    { rule = { instance = "cmus" },
    properties = { tag = tags[1][4],switchtotag = false } },
    -- news
    { rule = { instance = "newsbeuter" },
    properties = { tag = tags[1][5],switchtotag = false } },
    --file manager
    { rule = { class = "Dolphin" },
    properties = { tag = tags[1][7],switchtotag = true } },
    --misc stuff
    { rule = { class = "Konqueror" },
    properties = { tag = tags[1][6],switchtotag = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })
    -- remove gaps
    c.size_hints_honor = false

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart
--os.execute("blueman-applet &")
-- }}}

-- vim: fdm=marker fdl=0 sts=4 ai
