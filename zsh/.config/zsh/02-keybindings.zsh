#!/usr/bin/env zsh

# Vi with some Emacs flavor control keys.
bindkey -v
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^R" history-incremental-search-backward
bindkey "^U" kill-whole-line
bindkey "^W" vi-backward-kill-word
bindkey "^Y" yank

# '^?' (backspace) is bound to vi-backward-delete-char,
# which have an annoying behaviour to not delete char
bindkey -v '^?' backward-delete-char

# Navigate through history/zsh-autosuggestions with ctrl+j/k
bindkey '^K' history-beginning-search-backward
bindkey '^J' history-beginning-search-forward

# Use vim keys in complete tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# 'v' in visual mode opens vim to edit the command in a full editor.
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Execute custom script with keybind
# bindkey -s '^u' "furl^M" # ctrl+u fuzzy find URLs in current terminal window

# zsh-backward-delete-word () {
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle backward-delete-word
# }
# zle -N zsh-backward-delete-word
# bindkey '^W' zsh-backward-delete-word
