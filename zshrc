PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Add private exports
source $HOME/dotfiles/private
# Add custom exports
source $HOME/dotfiles/exports
# Add custom shell functions
source $HOME/dotfiles/functions
# Add custom aliases
source $HOME/dotfiles/aliases
# Add antigen defaults
source $HOME/.antigen/antigen.zsh

# Load my custom plugins
antigen bundle $HOME/dotfiles/completions/zsh --no-local-clone

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
rupa/z
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

# Tell antigen that you're done.
antigen apply