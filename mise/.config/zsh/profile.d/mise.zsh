#!/usr/bin/env zsh

export MISE_TRUSTED_CONFIG_PATHS="${MISE_TRUSTED_CONFIG_PATHS:-$XDG_CONFIG_HOME/mise}"
[ -d "$XDG_DATA_HOME/mise/shims" ] && export PATH="$XDG_DATA_HOME/mise/shims:$PATH"

# Set local config
# mise_dir=$XDG_CONFIG_HOME/mise
# [ ! -f $mise_dir/config.local.toml ] && ln -sf $mise_dir/config.{$(uname -n),local}.toml
# unset mise_dir
