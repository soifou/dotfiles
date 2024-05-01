#!/usr/bin/env zsh

if command -v mise > /dev/null; then
    export ASDF_CRATE_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/mise/default/rust
    export MISE_GO_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/mise/default/golang
    export MISE_NODE_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/mise/default/nodejs
    export MISE_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/mise/default/python

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
