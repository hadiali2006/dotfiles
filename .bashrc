#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --color=auto'
alias grep='grep --color=auto'
alias wa='feh --bg-fill --random ~/wallpapers'
alias oldnv='nvim'
alias nv='NVIM_APPNAME="nvim-kickstart" nvim'
alias nvhs='NVIM_APPNAME="nvim-hs" nvim'
alias gs='git status'
#PS1='[\u@\h \W]\$ '
PS1='\w \\$ '
export EDITOR='nvim'

[ -f "/home/hadi/.ghcup/env" ] && source "/home/hadi/.ghcup/env" # ghcup-env
