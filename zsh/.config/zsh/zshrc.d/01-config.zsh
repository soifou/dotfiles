#!/usr/bin/env zsh

# load complist module to make "menuselect" widget available to zle
zmodload zsh/complist
# display menu if nb items >= 2
zstyle ':completion:*' menu select=2
# forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate
# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash false
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
# case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

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
# LS_COLORS env variable need to be set. Either with eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# set cache file for completions
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
