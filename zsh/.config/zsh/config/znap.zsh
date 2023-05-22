#!/usr/bin/env zsh

znap_dir="$XDG_DATA_HOME"/zsh/znap

# Install znap
[ ! -f "$znap_dir"/znap.zsh ] && {
    ZNAP_INSTALL=1
    git clone --recursive \
        https://github.com/marlonrichert/zsh-snap "$znap_dir"
    # cd $znap_dir && git reset --hard af11309
    mkdir -p $XDG_DATA_HOME/zsh/plugins
}

zstyle ':znap:*' repos-dir $XDG_DATA_HOME/zsh/plugins

# Turn off git maintenance
zstyle ':znap:*:*' git-maintenance off

# Load znap
. "$znap_dir"/znap.zsh
unset znap_dir

# Load defer script
[ "$ZNAP_INSTALL" = "1" ] && znap source romkatv/zsh-defer || . "$XDG_STATE_HOME"/znap/romkatv/zsh-defer
