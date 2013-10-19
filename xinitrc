#!/bin/sh
eval "$(gpg-agent --daemon --enable-ssh-support)"
urxvtd -q -f -o
xrdb -load ~/.Xresources
xmodmap .Xmodmap &
setxkbmap  -layout de -variant neo
nm-applet --sm-disable &
exec i3
