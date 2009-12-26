#!/bin/sh
# ~/.xinitrc
eval "$(gpg-agent --daemon --sh)"
setxkbmap -layout de,de -variant neo,basic -option -option grp:sclk_toggle -option grp_led:scroll
awsetbg -c /home/flo/bilder/wallpaper/wispcat.jpg & 
xscreensaver -no-splash &

DEFAULT_SESSION=awesome
case $1 in
kde) 
	exec startkde
	;;
awesome)
	exec awesome
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac

