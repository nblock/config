#!/bin/sh
eval "$(gpg-agent --daemon)"
urxvtd -q -f -o
ck-launch-session nm-applet &
setxkbmap  -layout de,de -variant neo,basic -model pc105 -option -option grp:sclk_toggle -option grp_led:scroll
xrdb -load ~/.Xresources
xmodmap .Xmodmap &
exec awesome
