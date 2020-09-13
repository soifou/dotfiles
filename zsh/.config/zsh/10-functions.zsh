# Generate a random secure password
genpasswd() {
    length=${1:-20}
    [ $(uname) = "Darwin" ] && LC_ALL=C
    tr -dc A-Za-z0-9 </dev/urandom | head -c ${length} | xargs
}
# List sub dir, sort by size, the biggest at the end, with human presentation
dsd() {
    du --max-depth=1 -x -k | sort -n | awk 'function human(x) { s="KMGTEPYZ"; while (x>=1000 && length(s)>1) {x/=1024; s=substr(s,2)} return int(x+0.5) substr(s,1,1)"iB" } {gsub(/^[0-9]+/, human($1)); print}'
}
# Recursively find top 20 largest files (> 1MB) sort human readable format
dsf() { find . -type f -print0 | xargs -0 du -h | sort -hr | head -20 }
# git show particular commit in difftool
unalias gsd
gsd() { git difftool --no-symlinks --dir-diff $1~1 $1 }
# open remote origin in your browser
gor() { git config -l | grep remote.origin.url | awk -F= '{print $2}' | xargs setsid $BROWSER }
# capistrano alias turned into function (custom completions/_capit won't work with simple alias)
capit() { [ -f Gemfile ] && bundle exec cap $* }
# List commands from commandlinefu website
cmdfu() {
    curl "https://www.commandlinefu.com/commands/matching/$(echo "$@" \
    | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;
}
# Is website down for everyone or just me ?
down4me() { timeout 3 curl -s https://api.downfor.cloud/httpcheck/$1 | jshon }
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
chuck() { timeout 3 wget "http://api.icndb.com/jokes/random" -qO- | jshon -e value -e joke -u }
# Print a random (french) insult
insult-me() { timeout 3 wget "https://www.insult.es/api/random" -qO- | jshon -e insult -e value -u }
# Validate all XML files in the current directory and below
xmllint() { find . -type f -name "*.xml" -exec xmllint --noout {} \; }
# Download all files from a gist
dlgist() {
    if [ $# -ne 2 ];
    then
        echo 'Failed. Syntax: $> ddl-gist GITHUB_GIST_URL DOWNLOAD_PATH'
        return
    fi
    gist_url=$1
    download_path=$2
    echo '[*] Getting all GIST File URLs from '$gist_url
    gists=`curl -ksL -H 'User-Agent: Mozilla/5.0' $gist_url  | grep '<a\ .*href=".*/raw/' | sed 's/.*a\ .*href="//' | sed 's/".*//'`
    echo '[*] Downloading all files'
    for lines in `echo $gists | xargs -L1`;
    do
        if [ ! -z $lines ];
        then
            echo $lines
            gistfile=`echo $lines | sed 's/.*\///'`
            save_as=$download_path"/"$gistfile
            echo "Downloading URL: https://gist.github.com"$lines
            echo "to "$save_as"....."
            wget -c -O $save_as "https://gist.github.com"$lines
        fi
    done
}
# reveal aliases typed on prompt
reveal-alias() {
    preexec_functions=()
    function expand_aliases {
      input_command=$1
      expanded_command=$2
      if [ $input_command != $expanded_command ]; then
        print -nP $PROMPT
        echo $expanded_command
      fi
    }
    preexec_functions+=expand_aliases
}
# Python functions
if [ -d "${PYENV_ROOT}" ]; then
    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
    pip-upgrade() {
        pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
    }
fi
# Show how much RAM application uses.
# @credits: https://github.com/paulmillr/dotfiles/blob/master/home/.zshrc.sh#L282
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
