#!/usr/bin/env zsh

if command -v mise > /dev/null; then
    # Set local config
    [ ! -f $XDG_CONFIG_HOME/mise/config.local.toml ] \
        && ln -s $XDG_CONFIG_HOME/mise/config.{$(uname -n),local}.toml

    # Make available some binaries that might be used on startup.
    # These paths will be dynamically managed by mise during interactive shell.
    mise_bins=$(mise bin-paths | xargs | sed -e 's/ /:/g')
    [ -n mise_bins ] && {
        export PATH="$mise_bins:$PATH"
    }
    unset mise_bins

    ## go
    go_path=$(mise where golang)
    [ -n $go_path ] && {
        export GOPATH=$go_path/packages
    }
    unset go_path

    ## rust
    rust_path=$(mise where rust)
    [ -n $rust_path ] && {
        export RUSTUP_HOME=$rust_path/rustup
        export CARGO_HOME=$rust_path
    }
    unset rust_path
fi
