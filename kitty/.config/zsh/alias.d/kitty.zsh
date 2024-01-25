#!/usr/bin/env zsh

[ "$TERM" = 'xterm-kitty' ] && {
    # Alternative to git-delta
    alias diff='kitten diff'

    # Display images in the terminal
    alias icat='kitten icat'

    # Hyperlink ripgrep (rg) result of found occurences and allow to open it in
    # your editor. Need ripgrep v14.0 or higher.
    # Since kitty v0.32, one can hint visible hyperlinks instead of using mouse.
    alias rg='rg --hyperlink-format kitty'

    # Supercharge ssh connection
    alias ssh='kitten ssh'
}
