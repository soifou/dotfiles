#!/usr/bin/env zsh

# Source a .devrc file when entering a directory and unset if leaving the directory.
# Similar to what `direnv` does for env variables, but for aliases/functions.
# FIXME: Useless if mise eventually implement it: jdx/mise/issues/2034
#
# .devrc file MUST contains a `devrc-unset` function:
# ---
# foo() { echo bar; }
#
# devrc-unset() {
#     unset -f foo
# }
# ---
# Credits: https://gist.github.com/progrium/ea7cba82a90ac0d06fb2517e21761013

load-devrc() {
    if [[ -f .devrc && -r .devrc ]]; then
        echo "\e[92mSource .devrc\e[0m"
        source .devrc
    else
        if typeset -f devrc-unset > /dev/null; then
            echo "\e[93mUnsource .devrc\e[0m"
            devrc-unset
            unset -f devrc-unset
        fi
    fi
}
chpwd_functions+=(load-devrc)
