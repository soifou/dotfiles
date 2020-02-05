#!/bin/bash

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
        . "$ZDOTDIR/docker/functions.zsh"
        . "$ZDOTDIR/docker/aliases.zsh"
        if [ -e "$ZDOTDIR/docker/private.zsh" ]; then
            . "$ZDOTDIR/docker/private.zsh"
        fi
    fi

elif [[ $(uname) == "Linux" ]]; then
    # SSH key managed by gpg-agent
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
    ssh-add -l >/dev/null || ssh-add
    # Configure pinentry to use the correct TTY
    export GPG_TTY=$TTY
    gpg-connect-agent updatestartuptty /bye >/dev/null
    # SSH key managed by ssh-agent
    # if [ ! -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
    #     eval "$(ssh-agent)"
    #     ln -sf "$SSH_AUTH_SOCK" "$XDG_RUNTIME_DIR/ssh-agent.socket"
    # fi
    # ssh-add -l > /dev/null || ssh-add

    # Docker
    if command -v docker >/dev/null; then
        . "$ZDOTDIR/docker/functions.zsh"
        . "$ZDOTDIR/docker/aliases.zsh"
        [ -e "$ZDOTDIR/docker/private.zsh" ] && . "$ZDOTDIR/docker/private.zsh"
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
