#!/usr/bin/env zsh

# https://htr3n.github.io/2018/07/faster-zsh/
# https://200ok.ch/posts/2018-04-10_Make_zsh_recognise_Projects_you_are_working_on.html

# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof
# date "+%s.%N"

fpath=(
    "$ZDOTDIR"/completions
    "$ASDF_DATA_DIR"/completions
    "$HOMEBREW_PREFIX"/Homebrew/completions/zsh
    $fpath
)

for rc in $ZDOTDIR/*.zsh; do
    . $rc
done
unset rc

# uncomment to finish profiling
# zprof
# date "+%s.%N"
