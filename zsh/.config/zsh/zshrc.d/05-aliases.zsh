#!/usr/bin/env zsh

# Global aliases
alias ls="eza -a -F --hyperlink"
alias l="eza -la --group-directories-first --time-style=long-iso --hyperlink"
alias tree="eza -a --tree --icons"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias du='du -sh'
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias rm="rm -I --preserve-root"

# Unclutter home
alias feh="feh --no-fehbg -B background"
alias scummvm="scummvm -c $XDG_CONFIG_HOME"/scummvm/scummvmrc

for alias in $ZDOTDIR/alias.d/*.zsh; do . $alias; done
unset alias
