#!/usr/bin/env zsh

if command -v rtx > /dev/null; then
    export ASDF_CRATE_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/rtx/default/rust
    export RTX_GO_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/rtx/default/golang
    export RTX_NODE_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/rtx/default/nodejs
    export RTX_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME"/rtx/default/python

    # Make available some binaries that might be used on startup.
    # These paths will be dynamically managed by rtx during interactive shell.
    rtx_bins=$(rtx bin-paths | xargs | sed -e 's/ /:/g')
    export PATH="$rtx_bins:$PATH"
    unset rtx_bins

    ## go
    go_path=$(rtx where golang)
    export GOPATH=$go_path/packages
    unset go_path

    ## rust
    rust_path=$(rtx where rust)
    export RUSTUP_HOME=$rust_path/rustup
    export CARGO_HOME=$rust_path
    unset rust_path
fi
