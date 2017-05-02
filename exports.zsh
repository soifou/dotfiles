# Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
  export EDITOR=/usr/bin/vim
fi

export LESS="-FSRXI"

# add Rbenv
export RBENV_ROOT="$HOME/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:$PATH"
    eval "$(rbenv init -)"
fi
# add Pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# add Node Version Manager (nvm)
export NVM_ROOT="$HOME/.nvm"
if [ -d "${NVM_ROOT}" ]; then
    # NVM is slow: https://github.com/creationix/nvm/issues/860
    source "$NVM_ROOT/nvm.sh" --no-use
    export PATH=$HOME/.nvm/versions/node/v6.9.5/bin/:$PATH
fi

if [[ `uname` == "Darwin" ]]; then
    # homebrew path
    export PATH="/usr/local/sbin:$PATH"
    # use brewed coreutils instead of default one
    export COREUTILS_ROOT="$(brew --prefix coreutils)/libexec"
    if [ -d "${COREUTILS_ROOT}" ]; then
        export PATH="${COREUTILS_ROOT}/gnubin:$PATH"
    fi
    # Docker toolbox for my dev environment
    if [[ `docker-machine status $DOCKER_MACHINE_NAME` == "Running" ]]; then
        eval $(docker-machine env $DOCKER_MACHINE_NAME)
        source $HOME/dotfiles/docker/functions.zsh
        source $HOME/dotfiles/docker/aliases.zsh
        if [ -e "$HOME/dotfiles/docker/private.zsh" ]; then
            source $HOME/dotfiles/docker/private.zsh
        fi
    fi

elif [[ `uname` == "Linux" ]]; then
    # SSH
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

    # add docker
    if [ -f /usr/bin/docker ]; then
        source $HOME/dotfiles/docker/functions.zsh
        source $HOME/dotfiles/docker/aliases.zsh
        if [ -e "$HOME/dotfiles/docker/private.zsh" ]; then
            source $HOME/dotfiles/docker/private.zsh
        fi
    fi
    # add PHPBrew
    export PHPBREW_ROOT="$HOME/.phpbrew"
    if [ -d "${PHPBREW_ROOT}" ]; then
        export PHPBREW_SET_PROMPT=1
        export PHPBREW_RC_ENABLE=1
        source $PHPBREW_ROOT/bashrc
    fi
    # add LinuxBrew
    export LINUXBREW_ROOT="$HOME/.linuxbrew"
    if [ -d "${LINUXBREW_ROOT}" ]; then
        export PATH="$LINUXBREW_ROOT/bin:$PATH"
    fi
fi