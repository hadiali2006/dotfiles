#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --color=auto'
alias grep='grep --color=auto'
alias wa='feh --bg-fill --random ~/wallpapers'
alias nv='nvim'
alias nc="NVIM_APPNAME=nvim-nvchad nvim"
#PS1='[\u@\h \W]\$ '
PS1='\w \\$ '
export EDITOR='nvim'

