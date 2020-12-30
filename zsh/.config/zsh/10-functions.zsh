#!/usr/bin/env bash

# Generate a random secure password
genpasswd() {
    length=${1:-20}
    [ $(uname) = "Darwin" ] && LC_ALL=C
    tr -dc A-Za-z0-9 </dev/urandom | head -c ${length} | xargs
}
# List sub dir, sort by size, the biggest at the end, with human presentation
dsd() {
    du --max-depth=1 -x -k |\
    sort -n |\
    awk 'function human(x) { s="KMGTEPYZ"; while (x>=1000 && length(s)>1) {x/=1024; s=substr(s,2)} return int(x+0.5) substr(s,1,1)"iB" } {gsub(/^[0-9]+/, human($1)); print}'
}
# Recursively find top 20 largest files (> 1MB) sort human readable format
dsf() { find . -type f -print0 | xargs -0 du -h | sort -hr | head -20 }
# capistrano alias turned into function (custom completions/_capit won't work with simple alias)
capit() { [ -f Gemfile ] && bundle exec cap $* }
# List commands from commandlinefu website
cmdfu() {
    curl "https://www.commandlinefu.com/commands/matching/$(echo "$@" \
    | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;
}
# Cool CLI weather display
weather() { curl "wttr.in/$1" }
# Get external IP
whatsmyip() { echo "My external IP :`curl -s httpbin.org/ip | grep origin | awk -F: '{print $2}'`" }
# Dict protocol
dico() { curl -s dict://dict.org/d:${1}:wn | sed '/^[1-2]/d' | sed '$d'; }
dicofr() { curl -s dict://dict.org/d:${1}:fd-eng-fra | sed '/^[1-2]/d' | sed '$d'; }
# https://github.com/soimort/translate-shell
translate-shell() { gawk -f <(curl -Ls git.io/translate) -- -shell }
# Print a chuck norris joke
chuck() { timeout 3 wget "http://api.icndb.com/jokes/random" -qO- | jq ".value | .joke" | tr -d '"' }
# Print a random (french) insult
insult-me() { timeout 3 wget "https://www.insult.es/api/random" -qO- | jq ".[] | .value" | tr -d '"#' }
# Validate all XML files in the current directory and below
xmllint() { find . -type f -name "*.xml" -exec xmllint --noout {} \; }
# Download all files from a gist
dlgist() {
    [ $# -ne 2 ] && {
        echo 'Missing arguments. Syntax: $ dlgist GIST_URL DOWNLOAD_PATH'
        return
    }

    gist_url=$1
    download_path=$2
    mkdir -p $download_path
    echo '[*] Getting all GIST File URLs from '$gist_url
    gists=$(curl -ksL -H 'User-Agent: Mozilla/5.0' $gist_url | grep '<a\ .*href=".*/raw/' | sed 's/.*a\ .*href="//' | sed 's/".*//')
    echo '[*] Downloading all files'
    for lines in $(echo $gists | xargs -L1);
    do
        [ ! -z $lines ] && {
            echo $lines
            gistfile=`echo $lines | sed 's/.*\///'`
            save_as=$download_path"/"$gistfile
            echo "Downloading URL: https://gist.github.com"$lines
            echo "to "$save_as"....."
            wget -c -O $save_as "https://gist.github.com"$lines
        }
    done
}
# Python functions
if command -v pip >/dev/null 2>&1; then
    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
fi
# Show how much RAM application uses.
# Credits: https://github.com/paulmillr/dotfiles/blob/master/home/.zshrc.sh#L282
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
ram() {
    local sum
    local items
    local app="$1"
    if [ -z "$app" ]; then
        echo "First argument - pattern to grep from process"
    else
        sum=0
        for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
            sum=$(($i + $sum))
        done
        sum=$(echo "scale=2; $sum / 1024.0" | bc)
        if [[ $sum != "0" ]]; then
            echo "${fg[yellow]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
        else
            echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
        fi
    fi
}
# colorful man-pages
man() {
    export LESS_TERMCAP_md=$(tput bold; tput setaf 2) \
        LESS_TERMCAP_mb=$(tput bold; tput setaf 7) \
        LESS_TERMCAP_me=$(tput sgr0) \
        LESS_TERMCAP_so=$(tput setab 3; tput setaf 0) \
        LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
        LESS_TERMCAP_us=$(tput smul; tput setaf 1) \
        LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
        LESS_TERMCAP_mr=$(tput rev) \
        LESS_TERMCAP_mh=$(tput dim)
    command man "$@"
}
