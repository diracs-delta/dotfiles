# ~/.zshrc

[ -z “$PS1” ] && return
source ~/.shortcuts

# zsh features
autoload -Uz compinit bracketed-paste-magic url-quote-magic
compinit   			# fuzzy-autocompletion
ttyctl -f  			# disable terminal pause
(cat ~/.cache/wal/sequences &) 	# wal
set -o vi			# vi-mode
setopt autocd			# autocd
unsetopt nomatch

# command-line shortcuts
zle -N bracketed-paste bracketed-paste-magic	# auto-bracket clipboard input
zle -N self-insert url-quote-magic		# auto-quote urls

# adds color to ls, grep, and man output
alias ls="ls -h --color=auto --group-directories-first"
alias grep="grep --color=auto"
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# command aliases
alias p="sudo pacman"
alias lsl="ls -lah"
alias ka="killall"
alias mkd="mkdir -pv"
alias abcde="cd ~/Music && abcde -o flac -B"
alias dict="sdcv"
alias ypush="yadm commit -a && yadm push"
alias ypull="yadm clone https://github.com/hydrocodone-senpai/dotfiles -f && clear && yadm stash show -p"
alias mnova="/opt/MestReNova/bin/MestReNova"

# application aliases
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
alias n="ncmpcpp -q"
alias neofetch="clear && neofetch"
alias yt="youtube-viewer"
alias yta="youtube-dl -x --audio-format wav"
alias nmgui="nm-applet --no-agent"

# sets zsh environment 
export PATH="$PATH:$HOME/.scripts/bin" 	# set script path
export EDITOR=vim			# vim editor
export HISTFILE="$HOME/.zhistory" 	# history
export SAVEHIST=10000 			# history size
export LESSHISTFILE="/dev/null"    	# disables .lesshst log
export SDCV_PAGER=less			# sets output of stardict to less

if [ "$EUID" -ne 0 ]
	then export PS1="%B%F{blue}%n@%M%F{green} %3~ %F{magenta}%# %b%f"
	else export PS1="%B[%F{magenta}ROOT@$(hostname | awk '{print toupper($0)}')%F{green} %3~%f] %# "
fi