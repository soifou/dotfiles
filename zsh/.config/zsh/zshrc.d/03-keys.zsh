#!/usr/bin/env zsh

# Keybinds: man zshzle
# Set viins keymap as default (bindkey -l to list all)
bindkey -v

# Movements {{{

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
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^[' send-break
bindkey -M menuselect '^w' undo
bindkey -M menuselect '^o' accept-and-infer-next-history
# Default <C-d> behaviour (ignore_eof) has been disabled
bindkey '^d' reverse-menu-complete

# Move by physical lines, like gj/gk in vim
_physical_up_line()   { zle backward-char -n $COLUMNS; }
_physical_down_line() { zle forward-char  -n $COLUMNS; }
zle -N physical-up-line _physical_up_line
zle -N physical-down-line _physical_down_line
bindkey '^xk' physical-up-line
bindkey '^xj' physical-down-line

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

# Misc {{{

# Sync yanks with the system clipboard using OSC52
yank-osc52() {
    # Modify the buffer before storing the value into the clipboard
    # eg. q add quotes around if contains spaces
    # See `man zshexpn`
    # CUTBUFFER="${(q-)CUTBUFFER}"
    echo $CUTBUFFER | ${COPY_CMD} >/dev/null 2>&1
    printf "\033]52;c;%s\a" "$(printf %s $CUTBUFFER | head -c 8388608 | base64 -w 0)"
}

vi-yank-osc52() { zle vi-yank; yank-osc52; }
zle -N vi-yank-osc52
bindkey -M vicmd 'y' vi-yank-osc52

vi-yank-eol-osc52() { zle vi-yank-eol; yank-osc52; }
zle -N vi-yank-eol-osc52
bindkey -M vicmd 'Y' vi-yank-eol-osc52

vi-yankdel-osc52() { zle vi-delete; yank-osc52; }
zle -N vi-yankdel-osc52
bindkey -M vicmd 'd' vi-yankdel-osc52
bindkey -M vicmd -s 'D' 'd$'

# Append current command with sudo
_sudo-command-line() {
    [[ $BUFFER != sudo\ * ]] && LBUFFER="sudo $LBUFFER"
}
zle -N sudo-command-line _sudo-command-line
bindkey "^xs" sudo-command-line

# fg/bg
# Use c-z to toggle fg and bg
# https://gist.github.com/CMCDragonkai/6084a504b6a7fee270670fc8f5887eb4
toggle-ctrl-z() { fg; }
zle -N toggle-ctrl-z
bindkey '^z' toggle-ctrl-z

# Lf
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

# }}}

# vim: foldmethod=marker foldlevel=0 foldnestmax=1
