#!/usr/bin/env zsh

znap source ohmyzsh/ohmyzsh plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
    GIT_AUTO_FETCH_INTERVAL=30

znap source zsh-vi-more/vi-increment

[ -n $WAKATIME_HOME ] && {
    znap source sobolevn/wakatime-zsh-plugin
        [ -z $WAKATIME_API_KEY ] && export WAKATIME_API_KEY=$(pass wakapi/api-key)
        command -v wakatime-cli >/dev/null || ln -sf $WAKATIME_HOME/.wakatime/wakatime-cli $XDG_LOCAL_HOME/bin/wakatime-cli
        ZSH_WAKATIME_BIN=wakatime-cli
}

znap source zsh-users/zsh-autosuggestions
    # Defaults: zsh-users/zsh-autosuggestions/blob/master/src/config.zsh
    # FIXME: `completion` strategy break somehow kitty shell-integration cursor shape
    # Do not accept suggestion when using `forward-char` widget
    ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]/forward-char/}")
