# Pick a clipboard entry
command -v fzf > /dev/null && {
    fzf_greenclip() {
        CONTENT=$(greenclip print | grep -v '^\s*$' | nl -w2 -s' ' | fzf | sed -E 's/^ *[0-9]+ //')
        BUFFER="$BUFFER$CONTENT"
        CURSOR="$#BUFFER"
        zle redisplay
    }
    zle -N fzf_greenclip
    bindkey '^x;' fzf_greenclip
}

greenclip-cfg() {
    killall greenclip
    $EDITOR $XDG_CONFIG_HOME/greenclip.cfg && nohup greenclip daemon &> /dev/null &
}
greenclip-reload() {
    killall greenclip
    nohup greenclip daemon &> /dev/null &
}
greenclip-clear() {
    killall greenclip
    rm -f $XDG_CACHE_HOME/greenclip.history && nohup greenclip daemon &> /dev/null &
}
