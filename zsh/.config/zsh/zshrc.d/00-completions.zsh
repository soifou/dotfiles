#!/usr/bin/env zsh

command -v pip >/dev/null && {
    znap function _pip_completion pip 'eval "$(pip completion --zsh)"'
    compctl -K    _pip_completion pip
    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
}

[ $TERM = 'xterm-kitty' ] && {
    znap eval kitty 'kitty + complete setup zsh'
}

# command -v rustup > /dev/null && {
#     znap function _rustup rustup 'eval "$( rustup completions zsh rustup )"'
# }

# zoxide: https://github.com/ajeetdsouza/zoxide
command -v zoxide >/dev/null && {
    export _ZO_EXCLUDE_DIRS="/mnt:/tmp"
    znap eval zoxide 'zoxide init zsh'
}

# Docker
command -v docker >/dev/null && {
    for d in cli ui private ; do
        () { [ -f $1 ] && zsh-defer . $1 } "$ZDOTDIR"/docker/$d.zsh
    done

    alias dps='docker container ls --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
    alias dsp='docker system prune -f && docker volume prune -f'
}
