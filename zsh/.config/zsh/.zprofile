#!/usr/bin/env zsh

# Augmented PATH
## games
[ -d "/usr/games" ] && export PATH="/usr/games:$PATH"
## firefox latest
[ -d "/opt/firefox" ] && export PATH="/opt/firefox:$PATH"
## asdf
if [ -d "$ASDF_DATA_DIR" ]; then
    . "$ASDF_DATA_DIR"/asdf.sh
    export GOROOT="$ASDF_DATA_DIR"/installs/golang/$(asdf current golang | awk -F" " '{print $2}')/go
fi
## go
[ -d "$GOPATH" ] && export PATH="$GOPATH/bin:$PATH"
## composer
[ -d "$COMPOSER_HOME" ] && export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
## linuxbrew
if [ -d "$HOMEBREW_PREFIX" ]; then
    export HOMEBREW_NO_ANALYTICS=1
    export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}"
fi
## personal scripts
[ -d "$HOME"/.local/bin ] && export PATH="${$(find -L "$HOME"/.local/bin -type d -printf %p:)%%:}:$PATH"
