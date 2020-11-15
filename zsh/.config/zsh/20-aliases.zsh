#!/usr/bin/env zsh

# Global aliases
alias ls="exa"
alias l="exa -la --group-directories-first --time-style=long-iso"
alias lt="exa -T"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias du='du -sh'
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias rm="rm -I --preserve-root"

# Suffix
alias -s {mp4,MP4,mkv,MKV,mp3,MP3,mov,MOV,mpg,MPG,m4v,M4V,ogg,OGG,wav,WAV,webm,WEBM}='mpv'
alias -s {jpg,JPG,png,PNG,tif,TIF,tiff,TIFF}='sxiv -b'
alias -s {gif,GIF}='sxiv -ab'
alias -s {pdf,PDF,ps,PS}='zathura'

# Unclutter home
alias feh="feh --no-fehbg -B background"
alias mr="mr -c $XDG_CONFIG_HOME/myrepos/config -t"
alias yafc="yafc -W $XDG_CONFIG_HOME/yafc"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias scummvm="scummvm -c $XDG_CONFIG_HOME"/scummvm/scummvmrc
alias residualvm="residualvm -c $XDG_CONFIG_HOME"/residualvm/residualvmrc

# PHP
alias sf="php bin/console"
alias phpunit="php bin/phpunit"

# kitty terminal specifics
[ "$TERM" = 'xterm-kitty' ] && {
    alias diff='kitty +kitten diff'
    alias icat='kitty +kitten icat'
}
