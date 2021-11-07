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
zdharma-continuum/fast-syntax-highlighting
EOBUNDLES

# Plugins config

# omz/git-auto-fetch
GIT_AUTO_FETCH_INTERVAL=600

# zdharma/fast-syntax-highlighting
# Fix long git commit message highlight
export 'FAST_HIGHLIGHT[git-cmsg-len]=120'
[ -f "$XDG_CONFIG_HOME/fsh/base16.ini" ] && fast-theme -q XDG:base16

# zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
# Remove history-beginning-search-* widgets from list of widgets that clear autosuggestion
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#history-beginning-search-(back|for)ward}")

