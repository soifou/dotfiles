#!/usr/bin/env zsh

# Set GPG_TTY so gpg-agent knows where to prompt.
export GPG_TTY=$(tty)

# SSH key managed by gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
ssh-add -l >/dev/null || ssh-add

# Set pinentry prefered use method
case "$(tty)" in
    /dev/tty*) export PINENTRY_USER_DATA="tty" ;;
    /dev/pts*) export PINENTRY_USER_DATA="rofi" ;;
esac

# Updates the GPG-Agent TTY before every command
function _gpg-agent-update-tty {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
}
add-zsh-hook preexec _gpg-agent-update-tty
