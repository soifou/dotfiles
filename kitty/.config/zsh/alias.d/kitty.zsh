#!/usr/bin/env zsh

[ "$TERM" = 'xterm-kitty' ] && {
    alias diff='kitty +kitten diff'
    alias icat='kitty +kitten icat'
}
