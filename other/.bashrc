#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='eza --color=auto'
alias grep='grep --color=auto'
alias wa='feh --bg-fill --random ~/wallpapers'
alias oldnv='nvim'
alias nv='NVIM_APPNAME="nvim-kickstart" nvim'
alias nvhs='NVIM_APPNAME="nvim-hs" nvim'
alias gs='git status'
alias vol='wpctl get-volume @DEFAULT_AUDIO_SINK@'
set -o vi
PS1='\w \\$ '
export EDITOR='nvim'

[ -f "/home/hadi/.ghcup/env" ] && source "/home/hadi/.ghcup/env" # ghcup-env
export PATH=~/.npm-global/bin:$PATH 
export PATH=~/.local/bin:$PATH
