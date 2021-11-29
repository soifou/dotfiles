#!/usr/bin/env zsh

# Set GPG_TTY so gpg-agent knows where to prompt.
export GPG_TTY=$TTY
# Set pinentry prefered use method
# Disable GUI prompts inside SSH.
case "$GPG_TTY" in
    /dev/tty*) export PINENTRY_USER_DATA="tty" ;;
    /dev/pts*) export PINENTRY_USER_DATA="rofi" ;;
esac
# SSH key are managed by gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
ssh-add -l >/dev/null || ssh-add


