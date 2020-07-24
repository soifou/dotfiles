#!/usr/bin/env bash

# quick access to files and directories for POSIX shells.
# numerous tools exists, ie: autojump, z, v, fasd, zoxide.

# zoxide: https://github.com/ajeetdsouza/zoxide
if [ -x "$(command -v zoxide)" ]; then
    export _ZO_EXCLUDE_DIRS="/mnt:/tmp"
    eval "$(zoxide init zsh)"
fi

# fasd fork with XDG implementation: https://github.com/infokiller/fasd
if [ -x "$(command -v fasd)" ]; then
    fasd_cache="${XDG_CACHE_HOME:-/tmp}/fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    . "$fasd_cache"
    unset fasd_cache

    # combined with fzf
    unalias zz # fasd primarly set the following alias zz='fasd_cd -d -i'
    zz() {
        fasdlist=$(fasd -d -l -r $1 | fzf --query="$1 " --select-1 --exit-0 --height=25% --reverse --tac --no-sort --cycle)
        cd "$fasdlist"
    }
fi
