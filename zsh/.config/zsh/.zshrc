#!/usr/bin/env zsh

#-----------------------------------------------------
# Start profiling with the following command:
# $ ZSH_DEBUG=true zsh -i -c exit typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[ -z $ZSH_DEBUG ] || {
    zmodload zsh/zprof
    date "+%s.%N"
}

#-----------------------------------------------------
# Manage my SSH keys
() { [ -f $1 ] && . $1 } "$ZDOTDIR"/config/gpg.zsh

#-----------------------------------------------------
# Enable Powerlevel10k instant prompt.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
() { [ -r $1 ] && . $1 } "$XDG_CACHE_HOME"/p10k-instant-prompt-$USER.zsh

#-----------------------------------------------------
# Load completions
fpath=(
    "$ZDOTDIR"/completions
    "$ASDF_DATA_DIR"/completions
    "$HOMEBREW_PREFIX"/Homebrew/completions/zsh
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
# Load plugin manager
znap_dir="$XDG_DATA_HOME"/zsh/znap
[ ! -f "$znap_dir"/znap.zsh ] && {
    git clone --recursive \
        https://github.com/marlonrichert/zsh-snap "$znap_dir"
}
# Set specific location for plugins dir
zstyle ':znap:*' plugins-dir $XDG_DATA_HOME/zsh
# Turn off git maintenance
zstyle ':znap:*:*' git-maintenance off
. "$znap_dir"/znap.zsh
unset znap_dir
# Load defer script
znap source romkatv/zsh-defer

#-----------------------------------------------------
# Load options
() { [ -f $1 ] && . $1 } "$ZDOTDIR"/config/options.zsh

#-----------------------------------------------------
# Load zsh config by deferring them
for rc in $ZDOTDIR/zshrc.d/*.zsh; do
    zsh-defer . $rc
done
unset rc

#-----------------------------------------------------
# Load prompt
znap source romkatv/powerlevel10k
    () { [ -f $1 ] && . $1 } "$ZDOTDIR"/config/p10k.zsh

#-----------------------------------------------------
# Finish profiling
[ -z $ZSH_DEBUG ] || {
    zprof
    date "+%s.%N"
}
