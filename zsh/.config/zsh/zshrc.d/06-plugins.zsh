#!/usr/bin/env zsh

znap source ohmyzsh/ohmyzsh plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
    GIT_AUTO_FETCH_INTERVAL=30

znap source hlissner/zsh-autopair

znap source zdharma-continuum/fast-syntax-highlighting
    FAST_HIGHLIGHT[git-cmsg-len]=72

# additional completions
znap source zsh-users/zsh-autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
    # Remove history-beginning-search-* widgets from list of widgets that clear autosuggestion
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#history-beginning-search-(back|for)ward}")
