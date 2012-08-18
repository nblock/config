#!/bin/sh
eval "$(gpg-agent --daemon --enable-ssh-support)"
urxvtd -q -f -o
xrdb -load ~/.Xresources
xmodmap .Xmodmap &
#setxkbmap  -layout de,de -variant neo,basic -model pc106 -option -option grp:sclk_toggle -option grp_led:scroll
nm-applet --sm-disable &
exec ck-launch-session dbus-launch awesome
