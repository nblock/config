#!/bin/sh
eval "$(gpg-agent --daemon)"
urxvtd -q -f -o
ck-launch-session nm-applet &
xrdb -load ~/.Xresources
xmodmap .Xmodmap &
#setxkbmap  -layout de,de -variant neo,basic -model pc106 -option -option grp:sclk_toggle -option grp_led:scroll
exec awesome
