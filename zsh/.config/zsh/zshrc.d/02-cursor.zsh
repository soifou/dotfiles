#!/usr/bin/env zsh

# Cursor shapes {{{
cursor_block='\e[2 q'
cursor_beam='\e[6 q'
# Change cursor shape (beam or block) depending on vi mode (insert or normal)
terms=(rxvt-unicode-256color xterm-kitty wezterm)
zle-keymap-select() {
    if [ ${terms[(i)$TERM]} -le ${#terms} ]; then
        [ $KEYMAP = vicmd ] && echo -ne $cursor_block || echo -ne $cursor_beam
    fi
}
zle -N zle-keymap-select
# In case last command was aborted, restore beam cursor shape on new line
zle-line-init() {
    if [ -n $ZLE_LINE_ABORTED ]; then
        if [ ${terms[(i)$TERM]} -le ${#terms} ]; then
            [ $KEYMAP != vicmd ] && echo -ne $cursor_beam
        fi
    fi
}
zle -N zle-line-init
# }}}

# vim: foldmethod=marker foldlevel=0 foldnestmax=1
