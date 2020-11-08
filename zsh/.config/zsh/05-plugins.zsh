#!/usr/bin/env zsh

# See https://getantibody.github.io/usage/
. <(antibody init)
antibody bundle <<EOBUNDLES
# this block is in alphabetic order
robbyrussell/oh-my-zsh path:plugins/docker/_docker
robbyrussell/oh-my-zsh path:plugins/git/git.plugin.zsh
zlsun/solarized-man
zsh-users/zsh-autosuggestions
# these should be at last!
zdharma/fast-syntax-highlighting
EOBUNDLES
