#!/usr/bin/env zsh

#-----------------------------------------------------
# Start profiling with the following command:
# $ ZSH_DEBUG=true zsh -i -c exit typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[ -z $ZSH_DEBUG ] || {
    zmodload zsh/zprof
    date "+%s.%N"
}

#-----------------------------------------------------
# Enable Powerlevel10k instant prompt.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# () { [ -r $1 ] && . $1 } "$XDG_CACHE_HOME"/p10k-instant-prompt-$USER.zsh

#-----------------------------------------------------
# Load completions
fpath=(
    "$ZDOTDIR"/site-functions
    "$XDG_DATA_HOME"/zsh/site-functions
    "$HOMEBREW_PREFIX"/share/zsh/site-functions
    "$XDG_DATA_HOME"/rtx/installs/python/latest/share/zsh/site-functions
    $fpath
)

#-----------------------------------------------------
# Lazy-load functions
my_zsh_fpath=${ZDOTDIR}/autoload
fpath=($my_zsh_fpath $fpath)
[ -d "$my_zsh_fpath" ] && {
    for func in $my_zsh_fpath/*; do
        autoload -Uz ${func:t}
    done
}
unset my_zsh_fpath

#-----------------------------------------------------
# Load options
for i in znap options history; do
    () { [ -f $1 ] && . $1 } "$ZDOTDIR"/config/$i.zsh
done

#-----------------------------------------------------
# Load zsh config
for rc in $ZDOTDIR/zshrc.d/*.zsh; do zsh-defer . $rc; done
unset rc

#-----------------------------------------------------
# Load prompt
() { [ -f $1 ] && . $1 || znap source romkatv/powerlevel10k } "$XDG_STATE_HOME"/znap/romkatv/powerlevel10k
() { [ -f $1 ] && . $1 } "$ZDOTDIR"/config/p10k.zsh

#-----------------------------------------------------
# Finish profiling
[ -z $ZSH_DEBUG ] || {
    zprof
    date "+%s.%N"
}
