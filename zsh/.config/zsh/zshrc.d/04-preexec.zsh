#!/usr/bin/env zsh

# Uncomment to clean previous preexec functions
# This breaks execution time segment in p10k prompt
# preexec_functions=()

# Updates the GPG-Agent TTY before every command
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
__preexec_gpg_agent_update_tty() {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
}
preexec_functions=(__preexec_gpg_agent_update_tty ${preexec_functions[@]})

# Dynamically set delta "side-by-side" feature if screen is wide enough
# see: https://github.com/dandavison/delta/issues/359#issuecomment-751447860
# and https://github.com/wfxr/forgit/issues/121
# Note in case we use delta inside an fzf preview pane on wide screen
# we need to empty DELTA_FEATURES when invoking fzf.
__preexec_git_pager() {
    local columns=$(tput cols)
    export DELTA_FEATURES=""
    if [ $columns -ge 160 ]; then
        export DELTA_FEATURES="side-by-side"
    fi
}
typeset -ag preexec_functions
preexec_functions=(__preexec_git_pager ${preexec_functions[@]})

# Reveal aliases typed on prompt
reveal-alias() {
    __preexec_expand_aliases() {
        local input_command=$1
        local expanded_command=$2
        if [ $input_command != $expanded_command ]; then
            echo $expanded_command
        fi
    }
    preexec_functions=(__preexec_expand_aliases ${preexec_functions[@]})
}
unreveal-alias() {
    preexec_functions=${preexec_functions:|__preexec_expand_aliases}
}

# Remove duplicates if any
typeset -U preexec_functions
