PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Add custom exports
source $HOME/dotfiles/exports
# Add custom shell functions
source $HOME/dotfiles/functions
# Add custom aliases
source $HOME/dotfiles/aliases
# Add antigen defaults
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library and common bundles.
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
bundler
capistrano
command-not-found
composer
docker
fabric
gem
git
pip
sublime
symfony2
web-search
zsh-users/zsh-syntax-highlighting
EOBUNDLES

# Load OS specific bundles
if [[ `uname` == "Darwin" ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
elif [[ `uname` == "Linux" ]]; then
    antigen bundle debian
fi

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

# Load custom config for the theme
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_STATUS_VERBOSE=false

# Tell antigen that you're done.
antigen apply