source $HOME/dotfiles/preload.zsh
# Add antigen defaults
source $HOME/.antigen/antigen.zsh
# Load my custom plugins
antigen bundle $HOME/dotfiles/completions/zsh --no-local-clone
# Load the oh-my-zsh's library and common bundles.
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
bundler
capistrano
colored-man-pages
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
zsh-users/zsh-history-substring-search
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

# Source my customs
source $HOME/dotfiles/history.zsh
source $HOME/dotfiles/exports.zsh
if [ -e "$HOME/dotfiles/private.zsh" ]; then
    source $HOME/dotfiles/private.zsh
fi
source $HOME/dotfiles/functions.zsh
source $HOME/dotfiles/aliases.zsh