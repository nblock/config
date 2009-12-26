source /etc/profile

# start x bindings
xbindkeys

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

#sudo stuff
complete -cf sudo

#colored bash
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\] '

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
	TD=/mnt/flo/rdiff-backup
	BF=/home/flo/development/shelldev/backup-data
	if [ -d $TD ]; then
		sudo rdiff-backup -v 5 --include-globbing-filelist $BF / $TD
	else
		echo "$TD existiert nicht!"
	fi
}

#copy and go to dir
cpg (){
	if [ -d "$2" ];then
		cp $1 $2 && cd $2
	else
		cp $1 $2
	fi
}

#move and go to dir
mvg (){
	if [ -d "$2" ];then
		mv $1 $2 && cd $2
	else
		mv $1 $2
	fi
}
