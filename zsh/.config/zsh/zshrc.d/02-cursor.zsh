#!/usr/bin/env zsh

# Define cursor shapes
cursor_block='\e[1 q'
cursor_beam='\e[5 q'

set_cursor_shape() { echo -ne $1; }

# Set cursor shape based on vi mode
zle-keymap-select() {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        set_cursor_shape $cursor_block
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        set_cursor_shape $cursor_beam
    fi
}
zle -N zle-keymap-select

# Ensure beam cursor when starting new line
zle-line-init() {
    zle -K viins
    set_cursor_shape $cursor_beam
}
zle -N zle-line-init

# Ensure beam cursor when exiting zsh
zle-line-finish() {
    set_cursor_shape $cursor_beam
}
zle -N zle-line-finish

# Initial cursor shape
set_cursor_shape $cursor_beam

# Restore cursor shape before executing a command
preexec() {
    set_cursor_shape $cursor_beam
}
