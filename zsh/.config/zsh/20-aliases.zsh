#!/bin/sh

# Global aliases
alias ls="exa"
alias l="exa -la --group-directories-first --time-style=long-iso"
alias lt="exa -l -T"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias grep="grep --color=auto"

alias h5ai-selfupdate="cd $DEVELOPMENT_PATH/tools/h5ai && git pull && npm install && npm run build && mv build/h5ai-*.zip ../.. && cd $DEVELOPMENT_PATH && rm -rf _h5ai && unzip h5ai-*.zip && rm h5ai-*.zip"
# stay connected with Free Wifi
alias freewifi="while true ; do wget --quiet --no-check-certificate --post-data 'login=$FREEWIFI_ID&password=$FREEWIFI_PASS&submit=Valider' 'https://wifi.free.fr/Auth' -O '/dev/null' ; sleep 600; done"
alias https='http --default-scheme=https'
alias sf="php bin/console"

# find big files in git
alias gfb="git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | cut -c 1-12,41- | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"
alias gdd="git difftool --no-symlinks --dir-diff"

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
