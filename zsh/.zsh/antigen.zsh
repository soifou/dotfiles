# themes tweaks
# source $HOME/.zsh/themes/pl9k.zsh
# source $HOME/.zsh/themes/spaceship.zsh

# Add antigen defaults
source $HOME/.antigen/antigen.zsh
export ANTIGEN_COMPDUMP=$HOME/.zcompdump

# Load my custom plugins
antigen bundle $HOME/.zsh/completions --no-local-clone

# Load the oh-my-zsh's library and common bundles.
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
bundler
capistrano
command-not-found
docker
gem
git
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
# antigen theme bhilburn/powerlevel9k powerlevel9k
# antigen theme denysdovhan/spaceship-prompt spaceship

PURE_PROMPT_SYMBOL=λ
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done.
antigen apply
