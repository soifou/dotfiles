# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof
# date "+%s.%N"

source $HOME/dotfiles/preload.zsh
source $HOME/dotfiles/antigen.zsh
source $HOME/dotfiles/history.zsh
if [ -e "$HOME/dotfiles/private.zsh" ]; then
    source $HOME/dotfiles/private.zsh
fi
source $HOME/dotfiles/exports.zsh
source $HOME/dotfiles/functions.zsh
source $HOME/dotfiles/aliases.zsh

# uncomment to finish profiling
# zprof
# date "+%s.%N"