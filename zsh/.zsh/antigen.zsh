#!/bin/sh

# themes tweaks
# . $HOME/.zsh/themes/pl9k.zsh
# . $HOME/.zsh/themes/spaceship.zsh

# Add antigen defaults
. $HOME/.antigen/antigen.zsh

# Load custom completions
antigen bundle $HOME/.zsh/completions --no-local-clone
[ -d "$HOME/.anyenv" ] && eval "$($HOME/.anyenv/bin/anyenv init - zsh)"

# Load the oh-my-zsh's library and common bundles.
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
command-not-found
docker
git
zlsun/solarized-man
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
EOBUNDLES

# Load OS specific bundles
if [ "$(uname)" = "Darwin" ]; then
    antigen bundle brew
    antigen bundle brew-cask
elif [ -f /etc/debian_version ]; then
    antigen bundle debian
fi

# Load the theme.
# antigen theme bhilburn/powerlevel9k powerlevel9k
# antigen theme denysdovhan/spaceship-prompt spaceship
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done.
antigen apply
