#!/bin/sh

. <(antibody init)

antibody bundle <<EOBUNDLES
# this block is in alphabetic order
mafredri/zsh-async
robbyrussell/oh-my-zsh path:plugins/docker/_docker
robbyrussell/oh-my-zsh path:plugins/git/git.plugin.zsh
zlsun/solarized-man
zsh-users/zsh-autosuggestions
# these should be at last!
sindresorhus/pure
zdharma/fast-syntax-highlighting
zsh-users/zsh-history-substring-search
EOBUNDLES

# zsh-users/zsh-autosuggestions
# Ctrl+space to accept and execute current suggestion
bindkey '^ ' autosuggest-execute

# zdharma/fast-syntax-highlighting
# Set specific theme
[ -f "$XDG_CONFIG_HOME/fsh/soifou.ini" ] && fast-theme -q XDG:soifou
