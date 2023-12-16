#!/usr/bin/env zsh

[ "$TERM" = 'xterm-kitty' ] && {
    alias diff='kitten diff'
    alias icat='kitten icat'
    alias ssh='kitten ssh'

    # An enhance version of ripgrep (rg) that hyperlinked
    # the result of found occurences and allow to open it in your editor.
    #
    # Hyperlink is a relative new terminal feature but it involves to use
    # the mouse, which is an heresy.
    #
    # An interesting workaround was raised here:
    # https://github.com/kovidgoyal/kitty/discussions/5442#discussioncomment-4162976
    # It allows to use a pager that lets navigate to hyperlinks.
    #
    # Using a function instead of an alias allow to get files/folder expansion
    # rg() { kitten hyperlinked_grep --smart-case "$@"; }
    #
    # Since the release of ripgrep v14.0, hyperlinks are now builtin.
    # A notable difference is only line numbers are underlined instead of the
    # whole line.
    # See also: https://github.com/kovidgoyal/kitty/issues/6653
    alias rg='rg --hyperlink-format kitty'
}
