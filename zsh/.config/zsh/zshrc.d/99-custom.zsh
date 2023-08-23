#!/usr/bin/env zsh

command -v pip >/dev/null && {
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_pip ] && znap fpath _pip 'pip completion zsh'

    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
}

command -v rtx >/dev/null && {
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_rtx ] && znap fpath _rtx 'rtx completion zsh'
    znap eval rtx 'rtx activate zsh'
}

command -v zoxide >/dev/null && {
    export _ZO_EXCLUDE_DIRS="/mnt:/tmp"
    znap eval zoxide 'zoxide init zsh'
}

command -v docker >/dev/null && {
    for d in cli ui private ; do
        () { [ -f $1 ] && zsh-defer . $1 } "$ZDOTDIR"/config/docker/$d.zsh
    done

    alias dps='docker container ls --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
    alias dsp='docker system prune -f && docker volume prune -f'
}

command -v deno >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_deno ] && znap fpath _deno 'deno completions zsh'

command -v rustup >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_rustup ] && znap fpath _rustup 'rustup completions zsh'

command -v cargo >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_cargo ] && znap fpath _cargo 'rustup completions zsh cargo'

