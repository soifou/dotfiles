#!/usr/bin/env zsh

#-----------------------------------------------------
# Augmented PATH

## games
[ -d "/usr/games" ] && export PATH="/usr/games:$PATH"
## homebrew
if [ -d "$HOMEBREW_PREFIX" ]; then
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
    case $OSTYPE in
        darwin*)
            # prefer GNU utils when available
            for i in $(fd -t d --base-directory $HOMEBREW_PREFIX/Cellar gnubin | awk -F/ '{print $1}'); do
                export PATH="$HOMEBREW_PREFIX/opt/$i/libexec/gnubin:$PATH"
            done
            # For weird reasons, m4 from XCode on Sonoma must be used with brew:
            # See: https://github.com/facebookincubator/velox/issues/9190#issuecomment-2013730188
            # or https://github.com/facebookincubator/velox/pull/9717/files
            export PATH="$HOMEBREW_PREFIX/opt/m4/bin:$PATH"
        ;;
    esac
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
