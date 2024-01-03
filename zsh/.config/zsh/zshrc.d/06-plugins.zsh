#!/usr/bin/env zsh

znap source ohmyzsh/ohmyzsh plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
    GIT_AUTO_FETCH_INTERVAL=30

znap source zsh-vi-more/vi-increment

znap source zsh-users/zsh-autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
    # Reject autosuggestion when using vim `A`
    ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]/vi-add-eol/}")

znap source zdharma-continuum/fast-syntax-highlighting
    FAST_HIGHLIGHT[git-cmsg-len]=72
