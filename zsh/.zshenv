#!/bin/sh

# Add anyenv
if [ -d "$HOME/.anyenv" ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    # use classic gopath
    # export GOENV_DISABLE_GOROOT=0
    export GOENV_DISABLE_GOPATH=1
fi
# Add go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
# Add composer
[ -d "$HOME/.config/composer" ] && export PATH="$HOME/.config/composer/vendor/bin:$PATH"
# Add linuxbrew
[ -d "$HOME/.linuxbrew" ] && export PATH="$HOME/.linuxbrew/bin:$PATH"
# Add ~/.bin and all subdirectories
LOCAL_BINS="$PATH:$(du -L "$HOME/.bin" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$LOCAL_BINS:$PATH"
