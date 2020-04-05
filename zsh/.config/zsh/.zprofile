#!/usr/bin/env sh

# Augmented PATH
## games
[ -d "/usr/games" ] && export PATH="/usr/games:$PATH"
## firefox latest
[ -d "/opt/firefox" ] && export PATH="/opt/firefox:$PATH"
## anyenv
if [ -d "$HOME/.anyenv" ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - zsh)"
    export GOENV_DISABLE_GOPATH=1
fi
## go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
## composer
[ -d "$COMPOSER_HOME" ] && export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
## linuxbrew
[ -d "$HOME/.linuxbrew" ] && export PATH="$HOME/.linuxbrew/bin:$PATH"
## personal scripts
LOCAL_BINS="$(du -L "$HOME"/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$LOCAL_BINS:$PATH"
