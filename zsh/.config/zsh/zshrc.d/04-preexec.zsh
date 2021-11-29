#!/usr/bin/env zsh

preexec_functions=()

# [ "$TERM" = "xterm-kitty" ] && {
#     # Update kitty title bar on directory change
#     # Related config tab_title_template "{title}"
#     if (( ${+commands[kitty]} )); then
#         __preexec_kitty_update_tab_title() {
#             cur=$(pwd)
#             title="$(basename $cur)"
#             [ "$HOME" = "$cur" ] && { title="~" ; }
#             [ -d "$cur/.git" ] && { title=" $title" }
#             # kitty @ set-tab-title "--match=id:$((KITTY_WINDOW_ID - 1))" "$(basename $(pwd))"
#             kitty @ set-tab-title "$title"
#         }
#         precmd_functions+=(__preexec_kitty_update_tab_title)

#         # docwhat-starship-preexec() {
#         #   kitty @ set-tab-title "$1"
#         # }
#         # preexec_functions+=(docwhat-starship-preexec)
#     fi
#     # declare -Ua preexec_functions precmd_functions
# }

# Updates the GPG-Agent TTY before every command
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
__preexec_gpg_agent_update_tty() {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
}
preexec_functions=(__preexec_gpg_agent_update_tty ${preexec_functions[@]})

# Dynamically set delta "side-by-side" feature if screen is wide enough
# see: https://github.com/dandavison/delta/issues/359#issuecomment-751447860
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
