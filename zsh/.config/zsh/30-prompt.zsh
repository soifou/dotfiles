#!/usr/bin/env zsh

ZSH_PROMPT_THEME="${ZSH_PROMPT_THEME:-p10k}"

# Apply prompt theme
case "$ZSH_PROMPT_THEME" in
pure)
    antibody bundle mafredri/zsh-async
    antibody bundle sindresorhus/pure
    ;;
p10k) antibody bundle romkatv/powerlevel10k ;;
spaceship) antibody bundle denysdovhan/spaceship-prompt ;;
starship) eval "$(starship init zsh)" ;;
typewritten) antibody bundle reobin/typewritten ;;
bubble)
    antibody bundle robbyrussell/oh-my-zsh path:lib/
    antibody bundle hohmannr/bubblified path:bubblified.zsh-theme
    ;;
pista)
    autoload -Uz add-zsh-hook
    _pista_prompt() { PROMPT="$(pista -z)"; }
    add-zsh-hook precmd _pista_prompt
    ;;
random)
    OMZ_THEME=$(ls $(antibody path robbyrussell/oh-my-zsh)/themes | sed -n "$((RANDOM%$(ls | wc -l)+1))p")
    antibody bundle robbyrussell/oh-my-zsh path:lib/
    antibody bundle robbyrussell/oh-my-zsh path:themes/"$OMZ_THEME"
    echo ":: Loading random OMZ theme => $OMZ_THEME"
    ;;
esac

[ -f "$XDG_CONFIG_HOME/zsh/themes/$ZSH_PROMPT_THEME.zsh" ] &&
    . "$XDG_CONFIG_HOME/zsh/themes/$ZSH_PROMPT_THEME.zsh"

# tty colors with current colorscheme
# case "$(tty)" in
#     /dev/tty*)
#     if [ -d "$XDG_CACHE_HOME"/wal ]; then
#         (cat "$XDG_CACHE_HOME"/wal/sequences &)
#         . "$XDG_CACHE_HOME"/wal/colors-tty.sh
#     fi
#     ;;
# esac
