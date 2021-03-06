#!/usr/bin/env zsh

# Vi with some Emacs flavor control keys.
# Enter vi mode either by typing ESC, ALT-; ALT-m or CTRL-[
bindkey -v
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^R" history-incremental-search-backward
bindkey "^U" kill-whole-line
bindkey "^W" vi-backward-kill-word
bindkey "^Y" yank

# backspace and ^h working even after returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Navigate through history/zsh-autosuggestions
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^J' history-beginning-search-forward
bindkey '^K' history-beginning-search-backward
# bindkey '^K' history-search-backward             # Go back/search in history (autocomplete)
# bindkey '^J' history-search-forward              # Go forward/search in history (autocomplete)

# Use vim keys in complete tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Change cursor shape (beam or block) depending on vi mode (insert or normal)
zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "xterm-kitty" ] || [ "$TERM" = "screen-256color" ]; then
        [ $KEYMAP = vicmd ] && echo -ne '\e[1 q' || echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

# In case last command was aborted, restore beam cursor shape on new line
zle-line-init() {
    if [ -n $ZLE_LINE_ABORTED ]; then
        if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "xterm-kitty" ] || [ "$TERM" = "screen-256color" ]; then
            [ $KEYMAP != vicmd ] && echo -ne '\e[5 q'
        fi
    fi
}
zle -N zle-line-init

# 'v' in visual mode opens vim to edit the command in a full editor.
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# Different behaviour to delete words
# zsh-backward-delete-word () {
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle backward-delete-word
# }
# zle -N zsh-backward-delete-word
# bindkey '^W' zsh-backward-delete-word

# Execute custom script with keybind
# bindkey -s '^u' "furl^M" # ctrl+u fuzzy find URLs in current terminal window
