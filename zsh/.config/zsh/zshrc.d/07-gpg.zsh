#!/usr/bin/env zsh

# unset SSH_AGENT_PID

# SSH key are managed by gpg-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Set GPG_TTY so gpg-agent knows where to prompt.
export GPG_TTY=$TTY

# Set pinentry prefered use method
# Disable GUI prompts inside SSH.
case "$GPG_TTY" in
    /dev/tty*)
        case "$(uname -s)" in
            Darwin) export PINENTRY_USER_DATA=mac ;;
            *) export PINENTRY_USER_DATA=tty ;;
        esac
        ;;
    /dev/pts*) export PINENTRY_USER_DATA=rofi ;;
esac

# Updates the GPG-Agent TTY before every command
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
__preexec_gpg_agent_update_tty() {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
}
preexec_functions=(__preexec_gpg_agent_update_tty ${preexec_functions[@]})
