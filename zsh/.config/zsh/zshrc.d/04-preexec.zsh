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
