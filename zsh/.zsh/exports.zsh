# Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
  export EDITOR=/usr/bin/vim
fi

export LESS="-FSRXI"

# add my custom scripts
if [ -d "$HOME/.bin" ]; then
    export PATH="$HOME/.bin:$PATH"
fi

export COMPOSER_ROOT="$HOME/.composer"
if [ -d "${COMPOSER_ROOT}" ]; then
    export PATH="$COMPOSER_ROOT/vendor/bin:$PATH"
fi

export ANYENV_ROOT="$HOME/.anyenv"
if [ -d "${ANYENV_ROOT}" ]; then
    export PATH="$ANYENV_ROOT/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [[ `uname` == "Darwin" ]]; then
    # homebrew path
    export PATH="/usr/local/sbin:$PATH"
    # use brewed coreutils instead of default one
    export COREUTILS_ROOT="$(brew --prefix coreutils)/libexec"
    if [ -d "${COREUTILS_ROOT}" ]; then
        export PATH="${COREUTILS_ROOT}/gnubin:$PATH"
    fi
    # use brewed bzip2 (needed for phpbrew)
    export PATH="/usr/local/opt/bzip2/bin:$PATH"
    # use brew version of icu4c
    export PATH="/usr/local/opt/icu4c/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/sbin:$PATH"
    # Docker toolbox for my dev environment
    if [[ `docker-machine status $DOCKER_MACHINE_NAME` == "Running" ]]; then
        eval $(docker-machine env $DOCKER_MACHINE_NAME)
        source $HOME/.zsh/docker/functions.zsh
        source $HOME/.zsh/docker/aliases.zsh
        if [ -e "$HOME/.zsh/docker/private.zsh" ]; then
            source $HOME/.zsh/docker/private.zsh
        fi
    fi

elif [[ `uname` == "Linux" ]]; then
    # Support more than 256 colors
    export TERM="xterm-256color"
    # SSH
    if [ ! -S $XDG_RUNTIME_DIR/ssh-agent.socket ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" $XDG_RUNTIME_DIR/ssh-agent.socket
    fi
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
    ssh-add -l > /dev/null || ssh-add
    # add docker
    if [ -f /usr/bin/docker ]; then
        source $HOME/.zsh/docker/functions.zsh
        source $HOME/.zsh/docker/aliases.zsh
        if [ -e "$HOME/.zsh/docker/private.zsh" ]; then
            source $HOME/.zsh/docker/private.zsh
        fi
    fi
    # add LinuxBrew
    export LINUXBREW_ROOT="$HOME/.linuxbrew"
    if [ -d "${LINUXBREW_ROOT}" ]; then
        export PATH="$LINUXBREW_ROOT/bin:$PATH"
    fi
fi