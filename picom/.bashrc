#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --color=auto'
alias grep='grep --color=auto'
alias chw='feh --bg-fill --randomize ~/wallpapers/'
#PS1='[\u@\h \W]\$ '

PS1='\w \\$ '
