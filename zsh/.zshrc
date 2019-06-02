#!/bin/sh

# https://htr3n.github.io/2018/07/faster-zsh/
# https://coderwall.com/p/9fksra/speed-up-your-zsh-completions
# https://200ok.ch/posts/2018-04-10_Make_zsh_recognise_Projects_you_are_working_on.html

# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof
# date "+%s.%N"

. $HOME/.zsh/config.zsh
. $HOME/.zsh/antibody.zsh
. $HOME/.zsh/exports.zsh
. $HOME/.zsh/functions.zsh
. $HOME/.zsh/aliases.zsh
[ -e "$HOME/.zsh/private.zsh" ] && . $HOME/.zsh/private.zsh

# uncomment to finish profiling
# zprof
# date "+%s.%N"