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
alias tree="exa -a --tree --icons"

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

## Git
alias gaa='git add --all'
alias gba='git branch -a'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gd='git diff'
alias gdd="git difftool --no-symlinks --dir-diff"
alias gl='git pull'
alias gp='git push'
alias grh='git reset --hard'
alias gst='git status'
## This commands are declared in ~/.config/git/aliases
alias ga='git af'    # add file(s) to repository
alias gbd='git bd'   # delete branch(es)
alias gco='git co'   # checkout branch
alias gcp='git cp'   # cherry-pick
alias ghh='git h "border-left"'      # show commits history (vertical)
alias ghv='git h "down,border-top"'  # show commits history (horizontal)
alias gfh='git hf "border-left"'     # show commits history for particular file (vertical)
alias gfv='git hf "down,border-top"' # show commits history for particular file (horizontal)
alias gm='git bm'    # merge branch to current
alias gmg='git mg'   # list merged branch(es)
alias gmgd='git mgd' # delete merged branch(es)

# pastebin
alias ix="curl -F 'f:1=<-' ix.io"

# PHP
alias sf="php bin/console"
alias phpunit="php bin/phpunit"

# kitty terminal specifics
[ "$TERM" = 'xterm-kitty' ] && {
    alias diff='kitty +kitten diff'
    alias icat='kitty +kitten icat'
}
