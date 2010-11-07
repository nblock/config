#load arch default settings
if [ -r /etc/profile ] ; then
. /etc/profile
fi

#history and directory stack config
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
DIRSTACKSIZE=100
setopt HIST_IGNORE_SPACE	#commands with at least one space get ignored
setopt INC_APPEND_HISTORY	#share history between sessions	
setopt HIST_IGNORE_ALL_DUPS	#ignore history dups
setopt AUTO_PUSHD		#use automated directory stack
setopt PUSHD_IGNORE_DUPS	#ignore directory stack dups

#colors
eval `dircolors -b` 

#stuff
setopt AUTOCD			#autocd into dirs
setopt EXTENDEDGLOB		#use extended globbing
setopt CORRECTALL		#use autocorrection for commands and args
setopt NOBEEP			#avoid "beep"ing
setopt prompt_subst	# Enables additional prompt extentions

#environment variables
export EDITOR=vim
export BROWSER=firefox
export LANG=de_AT.UTF-8
export TERM=rxvt-unicode
export GPG_TTY=`tty`
PATH=$HOME/bin:$PATH
typeset -U PATH

#colors
autoload -U colors && colors

#set color vars
for COLOR in RED GREEN BLUE YELLOW; do
    eval CN_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval CB_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
C_RESET="%{${reset_color}%}";

#autocompletion
autoload -U compinit
compinit
zstyle ':completion:*' menu select #menu driven autocomplete
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' accept-exact '*(N)'

#version control info 
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "${CN_RED}▶"   #red sign if there are unstaged changes
zstyle ':vcs_info:*' stagedstr "${CN_YELLOW}▶"  #yellow sign if there are staged changes
zstyle ':vcs_info:*' formats "${CN_GREEN}%s${CB_BLUE}@${CB_RED}%b${C_RESET}"
zstyle ':vcs_info:(git):*' formats "${CN_GREEN}%s${CB_BLUE}@${CB_RED}%b${CN_BLUE}:${CB_RED}%u%c${C_RESET}"
zstyle ':vcs_info:*' branchformats "%b:%r"
function precmd {       
    vcs_info 'prompt'          
} 

### My default prompt
PROMPT=$'${CN_GREEN}%n${CB_BLUE}@${CB_RED}%m ${CN_BLUE}%~ ${CB_GREEN}$ ${C_RESET}'
RPROMPT='${vcs_info_msg_0_}'

### My prompt for loops
PROMPT2='{%_}  '
 
### My prompt for selections
PROMPT3='{ … }  '
 
### So far I don't use "setopt xtrace", so I don't need this prompt
PROMPT4=''

# auto extension alias
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

#no autocorrection for mv and cp
alias mv='nocorrect mv'
alias cp='nocorrect cp'

#normal alias
alias ls='ls --color=auto -F'
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

# key bindings (vim mode)
bindkey -v
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
bindkey "\^H" backward-delete-word
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
bindkey '^R' history-incremental-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

#hashes
hash -d fh5=~/fh-hagenberg/5.semester


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
	< /dev/urandom tr -dc '[](){}?!.,;_A-Z-a-z-0-9' | head -c${1:-20};echo;
}

#wrapper for rdiff-backup
function backup()
{
	TD=/media/sdb1/rdiff-backup
	BF=/home/flo/development/shelldev/backup-data
	if [ -d $TD ]; then
		sudo rdiff-backup -v 5 --include-globbing-filelist $BF / $TD
	else
		echo "$TD existiert nicht!"
	fi
}

