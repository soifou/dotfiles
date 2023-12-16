#!/usr/bin/env zsh

znap_dir="$XDG_DATA_HOME"/zsh/znap
znap_plugins_dir="$XDG_DATA_HOME"/zsh/plugins

# Install znap
[ ! -f "$znap_dir"/znap.zsh ] && {
    git clone --recursive \
        https://github.com/marlonrichert/zsh-snap "$znap_dir"
    mkdir -p $znap_plugins_dir
}

zstyle ':znap:*' repos-dir $znap_plugins_dir
# Turn off git maintenance
zstyle ':znap:*:*' git-maintenance off

# Load znap
. "$znap_dir"/znap.zsh

unset znap_plugins_dir
unset znap_dir

# Load defer script
() { [ -f $1 ] && . $1 || znap source romkatv/zsh-defer } "$XDG_STATE_HOME"/znap/romkatv/zsh-defer
