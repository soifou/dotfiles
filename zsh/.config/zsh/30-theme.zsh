# tty colors with current colorscheme
case "$(tty)" in
    /dev/tty*)
    if [ -d "$XDG_CACHE_HOME"/wal ]; then
        (cat "$XDG_CACHE_HOME"/wal/sequences &)
        . "$XDG_CACHE_HOME"/wal/colors-tty.sh
    fi
    ;;
esac

# zdharma/fast-syntax-highlighting
# Apply custom colorscheme
[ -f "$XDG_CONFIG_HOME/fsh/soifou.ini" ] && fast-theme -q XDG:soifou


# Apply prompt theme
case "${ZSH_PROMPT_THEME:-p10k}" in
pure)
    antibody bundle mafredri/zsh-async
    antibody bundle sindresorhus/pure
    PURE_PROMPT_SYMBOL=λ
    ;;
p10k)
    antibody bundle romkatv/powerlevel10k
    [ -f "$XDG_CONFIG_HOME/zsh/themes/p10k.zsh" ] && . "$XDG_CONFIG_HOME/zsh/themes/p10k.zsh"
    ;;
spaceship)
    antibody bundle denysdovhan/spaceship-prompt
    [ -f "$XDG_CONFIG_HOME/zsh/themes/$ZSH_PROMPT_THEME.zsh" ] && . "$XDG_CONFIG_HOME/zsh/themes/$ZSH_PROMPT_THEME.zsh"
    ;;
bubble)
    antibody bundle robbyrussell/oh-my-zsh path:lib/
    antibody bundle hohmannr/bubblified path:bubblified.zsh-theme
    # [ -f "$XDG_CONFIG_HOME/zsh/themes/bubble.zsh" ] && . "$XDG_CONFIG_HOME/zsh/themes/bubble.zsh"
    ;;
random)
    OMZ_THEME=$(ls $(antibody path robbyrussell/oh-my-zsh)/themes | sed -n "$((RANDOM%$(ls | wc -l)+1))p")
    antibody bundle robbyrussell/oh-my-zsh path:lib/
    antibody bundle robbyrussell/oh-my-zsh path:themes/"$OMZ_THEME"
    echo ":: Loading random OMZ theme => $OMZ_THEME"
    ;;
esac
