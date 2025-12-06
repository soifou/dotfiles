#!/usr/bin/env zsh

#-----------------------------------------------------
# Augmented PATH

## games
[ -d "/usr/games" ] && export PATH="/usr/games:$PATH"
## mason.nvim
[ -d "$XDG_DATA_HOME"/nvim/mason/bin ] && export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"
## nix
[ -f $XDG_CACHE_HOME/fsh/nix.sh ] && . $XDG_CACHE_HOME/fsh/nix.sh
## additionals
for profile in $ZDOTDIR/profile.d/*.zsh; do
    . $profile
done
unset profile
## personal scripts and wrappers
[ -d "$HOME"/.local/bin ] && export PATH="${$(find -L "$HOME"/.local/bin -type d -printf %p:)%%:}:$PATH"
