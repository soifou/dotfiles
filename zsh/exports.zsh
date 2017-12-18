# Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
  export EDITOR=/usr/bin/vim
fi

export LESS="-FSRXI"

# add my custom scripts
if [ -d "$HOME/.bin" ]; then
    export PATH="$HOME/.bin:$PATH"
fi
# add PHPenv
export PHPENV_ROOT="$HOME/.phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
    export PATH="$PHPENV_ROOT/bin:$PATH"
    eval "$(phpenv init -)"
fi
# add Composer
export COMPOSER_ROOT="$HOME/.composer"
if [ -d "${COMPOSER_ROOT}" ]; then
    export PATH="$COMPOSER_ROOT/vendor/bin:$PATH"
fi
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
    export PATH=$NVM_ROOT/versions/node/$(cat $NVM_ROOT/alias/default)/bin:$PATH
    # Calling nvm use automatically in a directory with a .nvmrc file
    autoload -U add-zsh-hook
    load-nvmrc() {
        if [[ -f .nvmrc && -r .nvmrc ]]; then
            nvm use
        fi
    }
    add-zsh-hook chpwd load-nvmrc
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
    if [ ! -S $XDG_RUNTIME_DIR/ssh-agent.socket ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" $XDG_RUNTIME_DIR/ssh-agent.socket
    fi
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
    ssh-add -l > /dev/null || ssh-add
    # add docker
    if [ -f /usr/bin/docker ]; then
        source $HOME/dotfiles/docker/functions.zsh
        source $HOME/dotfiles/docker/aliases.zsh
        if [ -e "$HOME/dotfiles/docker/private.zsh" ]; then
            source $HOME/dotfiles/docker/private.zsh
        fi
    fi
    # add LinuxBrew
    export LINUXBREW_ROOT="$HOME/.linuxbrew"
    if [ -d "${LINUXBREW_ROOT}" ]; then
        export PATH="$LINUXBREW_ROOT/bin:$PATH"
    fi
fi