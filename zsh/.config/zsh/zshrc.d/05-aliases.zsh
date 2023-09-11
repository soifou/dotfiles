#!/usr/bin/env zsh

# Global aliases
alias ls="eza -a -F --hyperlink"
alias l="eza -la --group-directories-first --time-style=long-iso --hyperlink"
alias tree="eza -a --tree --icons"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias du='du -sh'
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias rm="rm -I --preserve-root"

# Suffix
alias -s {mp4,MP4,mkv,MKV,mp3,MP3,mov,MOV,mpg,MPG,m4v,M4V,ogg,OGG,wav,WAV,webm,WEBM}='mpv'
alias -s {jpg,JPG,png,PNG,tif,TIF,tiff,TIFF}='nsxiv -b'
alias -s {gif,GIF}='nsxiv -ab'
alias -s {pdf,PDF,ps,PS}='zathura'

# Unclutter home
alias feh="feh --no-fehbg -B background"
alias scummvm="scummvm -c $XDG_CONFIG_HOME"/scummvm/scummvmrc

for alias in $ZDOTDIR/alias.d/*.zsh; do . $alias; done
unset alias
