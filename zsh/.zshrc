# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof
# date "+%s.%N"

source $HOME/.zsh/preload.zsh
source $HOME/.zsh/antigen.zsh
source $HOME/.zsh/history.zsh
if [ -e "$HOME/.zsh/private.zsh" ]; then
    source $HOME/.zsh/private.zsh
fi
source $HOME/.zsh/exports.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/aliases.zsh

# uncomment to finish profiling
# zprof
# date "+%s.%N"