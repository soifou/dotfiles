#!/usr/bin/env zsh

znap source ohmyzsh/ohmyzsh plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
    GIT_AUTO_FETCH_INTERVAL=30

znap source zsh-vi-more/vi-increment
znap source tunacuma/zsh-vi-man
    # ZVM_MAN_PAGER="less +G"

znap source zsh-users/zsh-autosuggestions
    # Defaults: zsh-users/zsh-autosuggestions/blob/master/src/config.zsh
    # FIXME: `completion` strategy break somehow kitty shell-integration cursor shape
    # Do not accept suggestion when using `forward-char` widget
    ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]/forward-char/}")

znap source zdharma-continuum/fast-syntax-highlighting
    FAST_HIGHLIGHT[git-cmsg-len]=72
