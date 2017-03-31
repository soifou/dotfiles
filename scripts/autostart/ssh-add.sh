#!/bin/sh

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
/usr/bin/ssh-add $HOME/.ssh/id_rsa </dev/null