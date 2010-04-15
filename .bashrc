source /etc/profile

# Check for an interactive session
[ -z "$PS1" ] && return

#ooo3.0 export...
export OOO_FORCE_DESKTOP=gnome
export EDITOR=vim
export LANG=de_AT.UTF-8
export TERM=rxvt-unicode
GPG_TTY=`tty`
export GPG_TTY


#colours
eval `dircolors -b`
export GREP_COLOR="1;33"
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias e=$EDITOR
alias se='sudo $EDITOR'
alias grep='grep --color=auto'
alias p='sudo pacman'
alias y='yaourt'
alias popt='sudo pacman-optimize && sync'
alias info='echo Dependencies: && pacman -Qd | wc -l && echo Explicitly: && pacman -Qe | wc -l && echo Total: && pacman -Q | wc -l'
alias R='y -Rscn'
alias Syu='y -Syu'
alias S='y -S'
alias Ss='y -Ss'
alias clean='y -Qdt && y -Scc'
alias hostip='curl icanhazip.com'
alias su='su -'
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
alias vgaon='xrandr --output VGA-0 --auto && xrandr --output LVDS --off && awsetbg -R ~/bilder/wallpaper/1920x1080/'
alias vgaoff='xrandr --output LVDS --auto && xrandr --output VGA-0 --off && awsetbg -R ~/bilder/wallpaper/1400x1050/'

#sudo stuff
complete -cf sudo

#colored bash
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\]\[\e[1;32m\]\[\033[31m\]$(__git_ps1 "(%s) ")\[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\]'

#extract various files with x $arg
function x()
{
	if [ -f "$1" ] ; then
		case "$1" in
			*.tar.bz2)  tar xjf "$1"      ;;
			*.tar.gz)   tar xzf "$1"      ;;
			*.tar.bz)   tar xzf "$1"      ;;
			*.tar.Z)    tar xzf "$1"      ;;
			*.bz2)      bunzip2 "$1"      ;;
			*.rar)      unrar x "$1"      ;;
			*.gz)       gunzip "$1"       ;;
			*.jar)      unzip "$1"        ;;
			*.tar)      tar xf "$1"       ;;
			*.tbz2)     tar xjf "$1"      ;;
			*.tgz)      tar xzf "$1"      ;;
			*.zip)      unzip "$1"        ;;
			*.Z)        uncompress "$1"   ;;
			*.7z)       7z x "$1"   ;;
			*)          echo "'$1' cannot be extracted." ;;
		esac
	else
		echo "'$1' is not a valid archive."
	fi
}

#generate random pw
function random()
{
	< /dev/urandom tr -dc '[](){}?!.,;_A-Z-a-z-0-9' | head -c$1
}

#wrapper for rdiff-backup
function backup()
{
	TD=/media/flo/rdiff-backup
	BF=/home/flo/development/shelldev/backup-data
	if [ -d $TD ]; then
		sudo rdiff-backup -v 5 --include-globbing-filelist $BF / $TD
	else
		echo "$TD existiert nicht!"
	fi
}
