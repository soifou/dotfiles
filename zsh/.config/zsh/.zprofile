#!/usr/bin/env zsh

#-----------------------------------------------------
# Augmented PATH

## games
[ -d "/usr/games" ] && export PATH="/usr/games:$PATH"
## firefox latest
[ -d "/opt/firefox" ] && export PATH="/opt/firefox:$PATH"
## homebrew
if [ -d "$HOMEBREW_PREFIX" ]; then
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
    # prefer GNU utils when available
    for i in coreutils grep; do
        if [ -d $HOMEBREW_PREFIX/opt/$i/libexec/gnubin ]; then
            export PATH="$HOMEBREW_PREFIX/opt/$i/libexec/gnubin:$PATH"
        fi
    done
fi
## composer
[ -d "$COMPOSER_HOME" ] && export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
## mason.nvim
[ -d "$XDG_DATA_HOME"/nvim/mason/bin ] && export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"
## personal scripts
[ -d "$HOME"/.local/bin ] && export PATH="${$(find -L "$HOME"/.local/bin -type d -printf %p:)%%:}:$PATH"

for profile in $ZDOTDIR/profile.d/*.zsh; do
    . $profile
done
unset profile
