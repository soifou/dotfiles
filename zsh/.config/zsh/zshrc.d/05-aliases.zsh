#!/usr/bin/env zsh

# Global aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias du='du -sh'
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias rm="rm -I"

for alias in $ZDOTDIR/alias.d/*.zsh; do . $alias; done
unset alias
