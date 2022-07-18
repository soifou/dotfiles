#!/usr/bin/env zsh

# See: man zshzle
WORDCHARS=
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
KEYTIMEOUT=1

# Set viins keymap as default (bindkey -l to list all)
bindkey -v

# Since default <C-d> behaviour (ignore_eof) has been disabled
# bind it to something meaningful.
bindkey '^d' reverse-menu-complete

bindkey '^xl' clear-screen
bindkey '^h' vi-backward-char
bindkey '^l' vi-forward-char
bindkey '^y' yank

# Add some Emacs flavor control keys.
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Keep backspace and ^w working even after returning from vimcmd
bindkey '^?' backward-delete-char
bindkey '^w' backward-delete-word

# Navigate through history/zsh-autosuggestions
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^j' history-beginning-search-forward
bindkey '^k' history-beginning-search-backward

# Perform history expansion using space
# See: https://zsh.sourceforge.io/Doc/Release/Expansion.html
bindkey ' ' magic-space

# Use vi motions in complete tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#-----------------------------------------------------
# Cursor shapes

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

#-----------------------------------------------------
# Zsh-contrib (man zshcontrib)
# https://github.com/zsh-users/zsh/tree/master/Functions/Zle

# Enhance vi mode text object for quote
# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# Enhance vi mode text object for brackets
# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

# Open editor with <C-e> on vicmd keymap
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line


#-----------------------------------------------------
# Custom

# Paste yanks to system clipboard
vi-yank-xclip() {
    zle vi-yank
    echo "$CUTBUFFER" | xclip -sel clip
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Use c-z to toggle fg and bg
# https://gist.github.com/CMCDragonkai/6084a504b6a7fee270670fc8f5887eb4
toggle-ctrl-z() { fg; }
zle -N toggle-ctrl-z
bindkey '^Z' toggle-ctrl-z

command -v fzf >/dev/null && {
    # Replace builtin <C-r> (backward incremental search)
    # with an fzf-driven, searchable list of history entries.
    # Credits: https://github.com/joshskidmore/zsh-fzf-history-search
    fzf_history_search() {
      candidates=(${(f)"$(fc -li -1 0 | fzf +s +m -x -e -q "$BUFFER")"})
      local ret=$?
      if [ -n "$candidates" ]; then
        BUFFER="${candidates[@]/(#m)*/${${(As: :)MATCH}[4,-1]}}"
        BUFFER="${BUFFER[@]/(#b)(?)\\n/$match[1]
    }"
        zle vi-fetch-history -n $BUFFER
      fi
      zle reset-prompt
      return $ret
    }
    autoload fzf_history_search
    zle -N fzf_history_search
    bindkey '^r' fzf_history_search

    # Fuzzy find children dirs of current with <C-f>
    bindkey -s '^f' '^Ucd "$(fd --type directory | fzf)"^M'
}

command -v lf >/dev/null && {
    # Enter lf from current dir with <C-o>
    # When quitting lf, it will sync the dir where we left on
    # Credits: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc
    lfcd () {
        tmp="$(mktemp -uq)"
        trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
        lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        fi
    }
    bindkey -s '^o' '^Ulfcd^M'
}
