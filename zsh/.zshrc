# https://htr3n.github.io/2018/07/faster-zsh/
# https://coderwall.com/p/9fksra/speed-up-your-zsh-completions
# https://200ok.ch/posts/2018-04-10_Make_zsh_recognise_Projects_you_are_working_on.html

# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof
# date "+%s.%N"

source $HOME/.zsh/preload.zsh
source $HOME/.zsh/antigen.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/exports.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/aliases.zsh
if [ -e "$HOME/.zsh/private.zsh" ]; then
    source $HOME/.zsh/private.zsh
fi

# uncomment to finish profiling
# zprof
# date "+%s.%N"