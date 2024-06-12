# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='%~ $ '

alias ls='eza --color=auto'
alias grep='grep --color=auto'
alias wa='feh --bg-fill --random ~/wallpapers'
alias nv='nvim'
alias nv2='NVIM_APPNAME="nvim3" nvim'
alias nvl='NVIM_APPNAME="lazyvim" nvim'
alias gs='git status'
alias vol='wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias awm='cd $AWM'

export EDITOR='nvim'
export AWM=~/.config/awesome/

export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.config/emacs/bin:$PATH
export PATH=~/go/bin:$PATH

# if [ -n "$WAYLAND_DISPLAY" ]; then
# export MOZ_ENABLE_WAYLAND=1
# fi

# export STARSHIP_CONFIG=~/.config/starship/starship.toml
# eval "$(starship init zsh)"
