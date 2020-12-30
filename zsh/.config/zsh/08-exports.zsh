#!/usr/bin/env sh

# zoxide: https://github.com/ajeetdsouza/zoxide
command -v zoxide >/dev/null && {
    export _ZO_EXCLUDE_DIRS="/mnt:/tmp"
    # static loading of zoxide init file (generated by zoxide init zsh)
    [ ! -f "$XDG_CACHE_HOME"/zoxide.zsh ] && zoxide init zsh >"$XDG_CACHE_HOME"/zoxide.zsh
    . "$XDG_CACHE_HOME"/zoxide.zsh
}

# Docker
command -v docker >/dev/null && {
    . "$ZDOTDIR"/docker/functions.zsh
    [ -e "$ZDOTDIR"/docker/private.zsh ] && . "$ZDOTDIR"/docker/private.zsh
}
