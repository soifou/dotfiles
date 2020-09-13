#!/usr/bin/env sh

# quick access to files and directories for POSIX shells.
# numerous tools exists, ie: autojump, z, v, fasd, zoxide.

# zoxide: https://github.com/ajeetdsouza/zoxide
if [ -x "$(command -v zoxide)" ]; then
    export _ZO_EXCLUDE_DIRS="/mnt:/tmp"
    eval "$(zoxide init zsh)"
fi
