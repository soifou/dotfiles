#!/usr/bin/env zsh

# Load complist module to make "menuselect" widget available to zle
zmodload zsh/complist
# Display menu if nb items >= 2
zstyle ':completion:*' menu select=2
# Forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate
# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# Rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash false
# Speedup completions
zstyle ':completion:*' accept-exact '*(N)'
# Kill processus
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=0;34=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# No users completion
zstyle ':completion:*:*:*:users' ignored-patterns '*' '_*'

# Override default behaviour for ssh/scp hosts completion.
# list only entries in ~/.ssh/config.d/* (OpenSSH >= 7.3) or ~/.ssh/config (prior to 7.3), not in /etc/hosts
# See: https://serverfault.com/questions/170346/how-to-edit-command-completion-for-ssh-on-zsh
if [ -r "$XDG_CONFIG_HOME"/ssh/config.d ]; then
    zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):*:hosts' hosts .zsh.hosts
    .zsh.hosts(){
        typeset -gaU reply=(
            ${${${(M)${(f)"$(cat "$XDG_CONFIG_HOME"/ssh/config.d/*)"}:#Host *}#Host }:#*[*?]*}
        )
    }
fi

# Use same colors as the ls command for file/dir completion
# LS_COLORS env variable need to be set. Either with eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Set cache file for completions
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zcompletions-$ZSH_VERSION

# Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
# in the background as this is doesn't affect the current session
# _zpcompinit_custom() {
#     setopt extendedglob local_options
#     autoload -Uz compinit
#     local zcd="$XDG_CACHE_HOME/zcompdump-$ZSH_VERSION"
#     local zcdc="$zcd.zwc"
#     if [[ -f "$zcd"(#qN.m+1) ]]; then
#         compinit -i -d "$zcd"
#         { rm -f "$zcdc" && zcompile "$zcd" } &!
#     else
#         compinit -C -d "$zcd"
#         { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
#     fi
# }
# _zpcompinit_custom

# Disable higlighted paste
zle_highlight=('paste:none')
