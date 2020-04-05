#!/usr/bin/env bash

if [ -x "$(command -v fasd)" ]; then
    fasd_cache="${XDG_CACHE_HOME:-/tmp}/fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    . "$fasd_cache"
    unset fasd_cache
fi
