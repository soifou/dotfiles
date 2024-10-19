#!/usr/bin/env zsh

if command -v mise > /dev/null; then

    [ -d "$XDG_DATA_HOME/mise/shims" ] && export PATH="$XDG_DATA_HOME/mise/shims:$PATH"

    # Set local config
    mise_dir=$XDG_CONFIG_HOME/mise
    [ ! -f $mise_dir/config.local.toml ] && {
        ln -sf $mise_dir/config.{$(uname -n),local}.toml
        # FIXME: Not detected on another partition (?!)
        [ -d /media ] && sudo ln -sf $mise_dir/config.local.toml /media/.mise.toml
    }
    unset mise_dir
fi
