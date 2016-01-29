PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Add custom exports
source $HOME/dotfiles/exports
# Add custom shell functions
source $HOME/dotfiles/functions
# Add custom aliases
source $HOME/dotfiles/aliases
# Add antigen defaults
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle bundler
antigen bundle capistrano
antigen bundle composer
antigen bundle debian
antigen bundle docker
antigen bundle fabric
antigen bundle gem
antigen bundle git
antigen bundle sublime
antigen bundle symfony2
antigen bundle web-search

# OS specific plugins
if [[ `uname` == "Darwin" ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
elif [[ `uname` == "Linux" ]]; then
    # none so far
fi

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

# Load custom config for the theme
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_STATUS_VERBOSE=false

# Tell antigen that you're done.
antigen apply