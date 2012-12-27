-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Required libraries
local awful = require("awful")
-- }}}

-- {{{ Main
theme = {}
theme._icondir = awful.util.getdir("config") .. "/icons"
theme.wallpaper = os.getenv("HOME") .. "/bilder/wallpaper/1440x900/arch_wall-by_kpolicano-1440x900.jpg"
-- }}}

-- {{{ Styles
theme.font      = "sans 8"

-- {{{ Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#00FF00"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#1E2320"
theme.bg_urgent = "#3F3F3F"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#FF0000"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
theme.titlebar_widget_height = "16"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "16"
theme.menu_width  = "100"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "/usr/share/awesome/themes/zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout icons
theme.layout_tile       = theme._icondir .. "/layouts/tile.png"
theme.layout_tileleft   = theme._icondir .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme._icondir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme._icondir .. "/layouts/tiletop.png"
theme.layout_fairv      = theme._icondir .. "/layouts/fairv.png"
theme.layout_fairh      = theme._icondir .. "/layouts/fairh.png"
theme.layout_spiral     = theme._icondir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme._icondir .. "/layouts/dwindle.png"
theme.layout_max        = theme._icondir .. "/layouts/max.png"
theme.layout_fullscreen = theme._icondir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme._icondir .. "/layouts/magnifier.png"
theme.layout_floating   = theme._icondir .. "/layouts/floating.png"
-- }}}

-- {{{ Widget icons
theme.widget_cpu    = theme._icondir .. "/taskbar/cpu.png"
theme.widget_bat    = theme._icondir .. "/taskbar/bat.png"
theme.widget_mem    = theme._icondir .. "/taskbar/mem.png"
theme.widget_fs     = theme._icondir .. "/taskbar/disk.png"
theme.widget_net    = theme._icondir .. "/taskbar/down.png"
theme.widget_netup  = theme._icondir .. "/taskbar/up.png"
theme.widget_wifi   = theme._icondir .. "/taskbar/wifi.png"
theme.widget_mail   = theme._icondir .. "/taskbar/mail.png"
theme.widget_vol    = theme._icondir .. "/taskbar/vol.png"
theme.widget_org    = theme._icondir .. "/taskbar/cal.png"
theme.widget_date   = theme._icondir .. "/taskbar/time.png"
theme.widget_crypto = theme._icondir .. "/taskbar/crypto.png"
theme.widget_sep    = theme._icondir .. "/taskbar/separator.png"
-- }}}

-- {{{ Titlebar icons
theme.titlebar_close_button_focus  = theme._icondir .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme._icondir .. "/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = theme._icondir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = theme._icondir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme._icondir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme._icondir .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = theme._icondir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = theme._icondir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme._icondir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme._icondir .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = theme._icondir .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = theme._icondir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme._icondir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme._icondir .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = theme._icondir .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme._icondir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme._icondir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme._icondir .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
