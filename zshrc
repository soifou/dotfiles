# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof
# date "+%s.%N"

source $HOME/dotfiles/zsh/preload.zsh
source $HOME/dotfiles/zsh/antigen.zsh
source $HOME/dotfiles/zsh/history.zsh
if [ -e "$HOME/dotfiles/zsh/private.zsh" ]; then
    source $HOME/dotfiles/zsh/private.zsh
fi
source $HOME/dotfiles/zsh/exports.zsh
source $HOME/dotfiles/zsh/functions.zsh
source $HOME/dotfiles/zsh/aliases.zsh

# uncomment to finish profiling
# zprof
# date "+%s.%N"