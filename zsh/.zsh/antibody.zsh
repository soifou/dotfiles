#!/bin/sh

. <(antibody init)

antibody bundle <<EOBUNDLES
# this block is in alphabetic order
mafredri/zsh-async
robbyrussell/oh-my-zsh path:plugins/docker/_docker
robbyrussell/oh-my-zsh path:plugins/git/git.plugin.zsh
zdharma/fast-syntax-highlighting
zlsun/solarized-man
zsh-users/zsh-autosuggestions
# these should be at last!
sindresorhus/pure
zdharma/fast-syntax-highlighting
zsh-users/zsh-history-substring-search
EOBUNDLES
