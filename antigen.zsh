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
docker
fabric
gem
git
n98-magerun
nvm
pip
sublime
wp-cli
rupa/z
zlsun/solarized-man
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
EOBUNDLES

# Load OS specific bundles
if [[ `uname` == "Darwin" ]]; then
    antigen bundle brew
    antigen bundle brew-cask
elif [ -f /etc/debian_version ]; then
    antigen bundle debian
fi

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

DEFAULT_USER=$USER # Only print user@hostname when not normal user
POWERLEVEL9K_MODE='nerdfont-fontconfig' # POWERLEVEL9K >= 0.6.x
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status nvm rbenv pyenv time)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=" \uf155 "
if [ -f /etc/debian_version ]; then
    POWERLEVEL9K_LINUX_ICON='\uf302'
    POWERLEVEL9K_OS_ICON_FOREGROUND="red"
fi
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_LOCK_ICON="\uf023"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_FOREGROUND="249"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="249"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="249"

POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"

POWERLEVEL9K_RUBY_ICON='\uf347 '
POWERLEVEL9K_RBENV_BACKGROUND="black"
POWERLEVEL9K_RBENV_FOREGROUND="249"
POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_COLOR="red"

POWERLEVEL9K_PYTHON_ICON='\ue73c'
POWERLEVEL9K_PYENV_BACKGROUND="black"
POWERLEVEL9K_PYENV_FOREGROUND="249"
POWERLEVEL9K_PYENV_VISUAL_IDENTIFIER_COLOR="yellow"

POWERLEVEL9K_NODE_ICON='\ue618 '
POWERLEVEL9K_NVM_BACKGROUND="black"
POWERLEVEL9K_NVM_FOREGROUND="249"
POWERLEVEL9K_NVM_VISUAL_IDENTIFIER_COLOR="green"

POWERLEVEL9K_STATUS_VERBOSE=false

# Tell antigen that you're done.
antigen apply