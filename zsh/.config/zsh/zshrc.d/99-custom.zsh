#!/usr/bin/env zsh

command -v eza >/dev/null && {
    alias ls="eza -a -F --hyperlink"
    alias l="eza -la --group-directories-first --time-style=long-iso --hyperlink"
    tree() {
        eza --tree -a --color=always --icons=always \
            --no-quotes --hyperlink --ignore-glob .git "$@" |
            sed '1d' | less
    }
}

command -v fd >/dev/null && {
    alias fd="fd --hyperlink=auto"
}

command -v pip >/dev/null && {
    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
}

command -v zoxide >/dev/null && {
    export _ZO_EXCLUDE_DIRS="$HOME:$XDG_CACHE_HOME/*:$XDG_STATE_HOME/*:/mnt/*:/tmp/*"
    export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
    znap eval zoxide 'zoxide init zsh'
}

command -v zsh-patina >/dev/null && {
    export ZSH_PATINA_CONFIG_PATH="$ZDOTDIR/config/zsh-patina.toml"
    znap eval zsh-patina 'zsh-patina activate'
    pgrep zsh-patina || zsh-patina restart
}

command -v docker >/dev/null && {
    for d in cli ui private ; do
        () { [ -f $1 ] && zsh-defer . $1 } "$ZDOTDIR"/config/docker/$d.zsh
    done

    alias dps='docker container ls --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
    alias dsp='docker system prune -f && docker volume prune -f'
}
