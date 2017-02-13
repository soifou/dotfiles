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
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_NVM_BACKGROUND="black"
POWERLEVEL9K_NVM_FOREGROUND="249"
POWERLEVEL9K_NVM_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status nvm rbenv virtualenv time)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VIRTUALENV_BACKGROUND='green'

# Tell antigen that you're done.
antigen apply