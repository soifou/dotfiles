#!/usr/bin/env zsh

# Global aliases
alias ls="exa"
alias l="exa -la --group-directories-first --time-style=long-iso"
alias lt="exa -T"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Suffix
alias -s {mp4,MP4,mkv,MKV,mp3,MP3,mov,MOV,mpg,MPG,m4v,M4V,ogg,OGG,wav,WAV,webm,WEBM}='mpv'
alias -s {jpg,JPG,png,PNG,tif,TIF,tiff,TIFF}='sxiv -b'
alias -s {gif,GIF}='sxiv -ab'
alias -s {pdf,PDF,ps,PS}='zathura'

# Defaults
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias rm="rm -i"
alias feh="feh --no-fehbg -B background"
alias mr="mr -c $XDG_CONFIG_HOME/myrepos/config -t"
alias yafc="yafc -W $XDG_CONFIG_HOME/yafc"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias scummvm="scummvm -c $XDG_CONFIG_HOME"/scummvm/scummvmrc
alias residualvm="residualvm -c $XDG_CONFIG_HOME"/residualvm/residualvmrc

# dev
alias https='http --default-scheme=https'
alias sf="php bin/console"
alias phpunit="php bin/phpunit"
# find big files in git
alias gfb="git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | cut -c 1-12,41- | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"
alias gdd="git difftool --no-symlinks --dir-diff"

# kitty terminal specifics
if [ "$TERM" = 'xterm-kitty' ]; then
    alias diff='kitty +kitten diff'
    alias icat='kitty +kitten icat'
fi

# Linux aliases
if [ "$(uname)" = "Linux" ]; then
    alias homebackup="luckybackup -c --no-questions default.profile"

# OSX aliases
elif [ "$(uname)" = "Darwin" ]; then
    alias osx-config="cd $HOME/Library/Application\ Support/"
    alias bs="brew services"
    alias ports="sudo lsof -i -P | grep -i listen"
    # Lock the screen (when going AFK)
    alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
    # Recursively delete `.DS_Store` files
    alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
    # Hide/show hidden files in Finder
    alias show-hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hide-hidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
    # Hide/show all desktop icons (useful when presenting)
    alias show-desktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
    alias hide-desktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
fi
