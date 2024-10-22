#!/usr/bin/env zsh

if command -v mise > /dev/null; then
    export MISE_NODE_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/mise/default/nodejs

    [ -d "$XDG_DATA_HOME/mise/shims" ] && export PATH="$XDG_DATA_HOME/mise/shims:$PATH"

    # Set local config
    mise_dir=$XDG_CONFIG_HOME/mise
    [ ! -f $mise_dir/config.local.toml ] && ln -sf $mise_dir/config.{$(uname -n),local}.toml
    unset mise_dir
fi
