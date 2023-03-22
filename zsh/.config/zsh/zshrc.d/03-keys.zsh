#!/usr/bin/env zsh

# Keybinds: man zshzle
# Set viins keymap as default (bindkey -l to list all)
bindkey -v

# Movements {{{
# Since default <C-d> behaviour (ignore_eof) has been disabled
# bind it to something meaningful.
bindkey '^d' reverse-menu-complete

bindkey '^xl' clear-screen
bindkey '^h' vi-backward-char
bindkey '^l' vi-forward-char

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
# ie, revealing previous command, !!<Space>
# See: https://zsh.sourceforge.io/Doc/Release/Expansion.html
bindkey ' ' magic-space

# Use vi motions in complete tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[' send-break

# }}}

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

# Contrib {{{
# man zshcontrib
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

# Add surround using "vim-sandwich" mapping style
bindkey -rM vicmd 's' # Remove vi-substitute
autoload -U surround
for op in add change delete; do
    zle -N $op-surround surround
done
bindkey -M vicmd 'sa' add-surround
bindkey -M vicmd 'sd' delete-surround
bindkey -M vicmd 'sr' change-surround
bindkey -M visual 'sa' add-surround
# Surround current command with $()
# <C-s> is available because of no_flow_control
bindkey -s "^s" '^a$(^e)^a'

# Open editor with <C-e> on vicmd keymap
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line
# }}}

# Yank {{{
# Sync with the system clipboard using OSC52
yank-osc52() {
    # Use zsh 'q' flag to escape shell-special characters
    # See `man zshexpn`
    CUTBUFFER="${(q-)CUTBUFFER}"
    echo $CUTBUFFER | ${COPY_CMD} >/dev/null 2>&1
    maxbuf=8388608
    printf "\033]52;c;$(printf %s $CUTBUFFER | head -c $maxbuf | base64 | tr -d '\r\n')\a"
}
vi-yank-osc52() { zle vi-yank; yank-osc52; }
zle -N vi-yank-osc52
vi-yank-eol-osc52() { zle vi-yank-eol; yank-osc52; }
zle -N vi-yank-eol-osc52

bindkey '^y' yank
bindkey -M vicmd 'y' vi-yank-osc52
bindkey -M vicmd 'Y' vi-yank-eol-osc52
# }}}

# fg/bg {{{
# Use c-z to toggle fg and bg
# https://gist.github.com/CMCDragonkai/6084a504b6a7fee270670fc8f5887eb4
toggle-ctrl-z() { fg; }
zle -N toggle-ctrl-z
bindkey '^Z' toggle-ctrl-z
# }}}

# Fzf {{{
command -v fzf >/dev/null && {
    # Replace builtin <C-r> (backward incremental search)
    # with an fzf-driven, searchable list of history entries.
    # Credits: https://github.com/joshskidmore/zsh-fzf-history-search
    fzf_history_search() {
      candidates=(${(f)"$(fc -li -1 0 | fzf --info=hidden +s -e -q "$BUFFER")"})
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
}# }}}

# Lf {{{
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
}# }}}

# vim: foldmethod=marker foldlevel=0 foldnestmax=1
