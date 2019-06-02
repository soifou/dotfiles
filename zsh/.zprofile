#!/bin/sh

# Augmented PATH
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
[ -d "$HOME/.config/composer" ] && export PATH="$HOME/.config/composer/vendor/bin:$PATH"
## linuxbrew
[ -d "$HOME/.linuxbrew" ] && export PATH="$HOME/.linuxbrew/bin:$PATH"
## custom ~/.bin and all subdirectories
LOCAL_BINS="$(du -L "$HOME/.bin" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$LOCAL_BINS:$PATH"
