#!/bin/bash

if [ -x "$(command -v fasd)" ]; then
    fasd_cache="${XDG_CACHE_HOME:-/tmp}/fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    . "$fasd_cache"
    unset fasd_cache
fi

if [[ $(uname) == "Darwin" ]]; then
    # homebrew path
    export PATH="/usr/local/sbin:$PATH"
    # use brewed coreutils instead of default one
    COREUTILS_ROOT="$(brew --prefix coreutils)/libexec"
    export COREUTILS_ROOT="$COREUTILS_ROOT"
    if [ -d "${COREUTILS_ROOT}" ]; then
        export PATH="${COREUTILS_ROOT}/gnubin:$PATH"
    fi
    # use brewed bzip2 (needed for phpbrew)
    export PATH="/usr/local/opt/bzip2/bin:$PATH"
    # use brew version of icu4c
    export PATH="/usr/local/opt/icu4c/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/sbin:$PATH"
    # Docker toolbox for my dev environment
    if [[ $(docker-machine status "$DOCKER_MACHINE_NAME") == "Running" ]]; then
        eval "$(docker-machine env $DOCKER_MACHINE_NAME)"
        . "$HOME/.zsh/docker/functions.zsh"
        . "$HOME/.zsh/docker/aliases.zsh"
        if [ -e "$HOME/.zsh/docker/private.zsh" ]; then
            . "$HOME/.zsh/docker/private.zsh"
        fi
    fi

elif [[ $(uname) == "Linux" ]]; then
    # SSH
    if [ ! -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
        eval "$(ssh-agent)"
        ln -sf "$SSH_AUTH_SOCK" "$XDG_RUNTIME_DIR/ssh-agent.socket"
    fi
    ssh-add -l > /dev/null || ssh-add

    # Docker
    if [ -f /usr/bin/docker ]; then
        . "$HOME/.zsh/docker/functions.zsh"
        . "$HOME/.zsh/docker/aliases.zsh"
        [ -e "$HOME/.zsh/docker/private.zsh" ] && . "$HOME/.zsh/docker/private.zsh"
    fi

elif [[ $(uname) == "OpenBSD" ]]; then
    export PATH="/usr/X11R6/bin:$PATH"
    # SSH
    if [ ! -S "$HOME/.ssh-agent.socket" ]; then
        eval "$(ssh-agent)"
        ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh-agent.socket"
    fi
    export SSH_AUTH_SOCK=$HOME/.ssh-agent.socket
    ssh-add -l > /dev/null || ssh-add
fi
