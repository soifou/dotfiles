#!/usr/bin/env zsh

command -v eza >/dev/null && {
    alias ls="eza -a -F --hyperlink"
    alias l="eza -la --group-directories-first --time-style=long-iso --hyperlink"
    tree() { eza -a --tree --icons "$@" }
}

command -v pip >/dev/null && {
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_pip ] && znap fpath _pip 'pip completion zsh'

    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
}

command -v mise >/dev/null && {
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_mise ] && znap fpath _mise 'mise completion zsh'
    znap eval mise 'mise activate zsh'
}

command -v zoxide >/dev/null && {
    export _ZO_EXCLUDE_DIRS="$HOME:$XDG_CACHE_HOME/*:$XDG_STATE_HOME/*:/mnt/*:/tmp/*"
    znap eval zoxide 'zoxide init zsh'
}

command -v docker >/dev/null && {
    for d in cli ui private ; do
        () { [ -f $1 ] && zsh-defer . $1 } "$ZDOTDIR"/config/docker/$d.zsh
    done

    alias dps='docker container ls --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
    alias dsp='docker system prune -f && docker volume prune -f'
}

command -v rg >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_ripgrep ] && znap fpath _ripgrep 'rg --generate=complete-zsh'

command -v deno >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_deno ] && znap fpath _deno 'deno completions zsh'

command -v rustup >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_rustup ] && znap fpath _rustup 'rustup completions zsh'

command -v cargo >/dev/null &&
    [ ! -f $XDG_DATA_HOME/zsh/site-functions/_cargo ] && znap fpath _cargo 'rustup completions zsh cargo'
