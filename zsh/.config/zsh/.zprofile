#!/usr/bin/env zsh

#-----------------------------------------------------
# SSH key are managed by gpg-agent
# The custom location of GNUPGHOME prevents me to set the following
# hardcoded path "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

#-----------------------------------------------------
# Augmented PATH

## games
[ -d "/usr/games" ] && export PATH="/usr/games:$PATH"
## firefox latest
[ -d "/opt/firefox" ] && export PATH="/opt/firefox:$PATH"
## linuxbrew
if [ -d "$HOMEBREW_PREFIX" ]; then
    export HOMEBREW_NO_ANALYTICS=1
    export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}"
fi
## composer
[ -d "$COMPOSER_HOME" ] && export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
## mason.nvim
[ -d "$XDG_DATA_HOME"/nvim/mason/bin ] && export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"
## personal scripts
[ -d "$HOME"/.local/bin ] && export PATH="${$(find -L "$HOME"/.local/bin -type d -printf %p:)%%:}:$PATH"

for profile in $ZDOTDIR/profile.d/*.zsh; do
    . $profile
done
unset profile
