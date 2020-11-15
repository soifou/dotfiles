#!/usr/bin/env zsh

# Plugin manager
# See https://getantibody.github.io/usage/
. <(antibody init)
antibody bundle <<EOBUNDLES
# this block is in alphabetic order
robbyrussell/oh-my-zsh path:plugins/docker/_docker
robbyrussell/oh-my-zsh path:plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
zsh-users/zsh-autosuggestions
# these should be at last!
zdharma/fast-syntax-highlighting
EOBUNDLES

# Plugins config

# omz/git-auto-fetch
GIT_AUTO_FETCH_INTERVAL=600

# zdharma/fast-syntax-highlighting
# Fix long git commit message highlight
export 'FAST_HIGHLIGHT[git-cmsg-len]=120'
# [ -f "$XDG_CONFIG_HOME/fsh/soifou.ini" ] && fast-theme -q XDG:soifou

# zsh-users/zsh-autosuggestions
# export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
# ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(fzf-completion vi-cmd-mode)
