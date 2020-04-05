#!/usr/bin/env sh

. <(antibody init)

antibody bundle <<EOBUNDLES
# this block is in alphabetic order
robbyrussell/oh-my-zsh path:plugins/docker/_docker
robbyrussell/oh-my-zsh path:plugins/git/git.plugin.zsh
zlsun/solarized-man
zsh-users/zsh-autosuggestions
# these should be at last!
zdharma/fast-syntax-highlighting
zsh-users/zsh-history-substring-search
EOBUNDLES

## Config

# zsh-users/zsh-autosuggestions
# export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# export ZSH_AUTOSUGGEST_USE_ASYNC=1
# Ctrl+space to accept and execute current suggestion
# bindkey '^ ' autosuggest-execute

# zdharma/fast-syntax-highlighting
# Fix long git commit message highlight
export 'FAST_HIGHLIGHT[git-cmsg-len]=120'