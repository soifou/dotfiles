#!/usr/bin/env zsh

# allow to customize menu select
zstyle ':completion:*' menu select
# forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate
# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash true
# menu if nb items > 2
zstyle ':completion:*' menu select=2
# speedup completions
zstyle ':completion:*' accept-exact '*(N)'
# kill processus
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# no users completion
zstyle ':completion:*:*:*:users' ignored-patterns '*' '_*'
# Override default behaviour for ssh/scp hosts completion.
# list only entries in ~/.ssh/config.d/* (OpenSSH >= 7.3) or ~/.ssh/config (prior to 7.3), not in /etc/hosts
# @see: https://serverfault.com/questions/170346/how-to-edit-command-completion-for-ssh-on-zsh
h=()
if [[ -r "$XDG_CONFIG_HOME"/ssh/config.d ]]; then
    h=($h ${${${(@M)${(f)"$(cat "$XDG_CONFIG_HOME"/ssh/config.d/*)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ $#h -gt 0 ]]; then
    zstyle ':completion::complete:scp:*' hosts $h
    zstyle ':completion::complete:ssh:*' hosts $h
fi
unset h

# use same colors as the ls command for file/dir completion
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# set cache file for completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zcompletions-$ZSH_VERSION
# load complist module to make "menuselect" widget available to zle
zmodload zsh/complist

# autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zcompdump-$ZSH_VERSION
_zpcompinit_custom() {
    setopt extendedglob local_options
    autoload -Uz compinit
    local zcd="$XDG_CACHE_HOME/zcompdump-$ZSH_VERSION"
    local zcdc="$zcd.zwc"
    # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
    # in the background as this is doesn't affect the current session
    if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
    else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
    fi
}
_zpcompinit_custom

# Make sure the terminal is in application mode when zle is active,
# since only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    zle-line-init() {
        echoti smkx
    }
    zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

bindkey -e                       # emacs keybindings
bindkey "^[[1;5C" forward-word   # ctrl+right navigate to next word
bindkey "^[[1;5D" backward-word  # ctrl+left navigate to previous word
bindkey '\ew' kill-region        # esc+w clear all before cursor

# zsh-backward-delete-word () {
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle backward-delete-word
# }
# zle -N zsh-backward-delete-word
# bindkey '^W' zsh-backward-delete-word
bindkey '^W' vi-backward-kill-word # ctrl+w delete a word, stop at word char (see $WORDCHARS)
bindkey '^H' backward-kill-word    # ctrl+backspace delete entirely previous word

# Execute custom script with keybind
# bindkey -s '^u' "furl^M" # ctrl+u fuzzy find URLs in current terminal window

# Use vim keys in complete tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Options
setopt auto_cd                   # cd when just a path is entered
setopt globdots                  # lets files beginning with a . be matched without explicitly specifying the dot.
setopt no_flow_control           # Disable start (C-s) and stop (C-q)

# History
setopt bang_hist                 # Treat the '!' character specially during expansion.
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_ignore_space         # Don't record an entry starting with a space.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry.
setopt hist_verify               # Don't execute immediately upon history expansion.
setopt hist_beep                 # Beep when accessing nonexistent history.

# Disable higlighted paste
zle_highlight=('paste:none')

# Autosuggestion based from history
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Completion for kitty
# command -v kitty >/dev/null && kitty + complete setup zsh | source /dev/stdin
