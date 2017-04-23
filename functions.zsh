# Generate a random secure password
genpasswd() {
    length=$1
    if [ -z $length ]; then length=20; fi
    if [[ `uname` == "Darwin" ]]; then
        LC_ALL=C tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${length} | xargs
    elif [[ `uname` == "Linux" ]]; then
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${length} | xargs
    fi
}
# List commands from commandlinefu website
cmdfu() {
    curl "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
    | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;
}
# Is website down for everyone or just me ?
down4me() { curl -s "http://www.isup.me/$1" | sed '/just you/!d;s/<[^>]*>//g'; }
# Cool CLI weather display
weather() { curl wttr.in/$1 }
# Get external IP
whatsmyip() { echo "My external IP :`curl -s httpbin.org/ip | grep origin | awk -F: '{print $2}'`" }
# Dict protocol
dico() { curl -s dict://dict.org/d:${1}:wn | sed '/^[1-2]/d' | sed '$d'; }
dicofr() { curl -s dict://dict.org/d:${1}:fd-eng-fra | sed '/^[1-2]/d' | sed '$d'; }
# Print a chuck norris joke
chuck() { timeout 3 wget "http://api.icndb.com/jokes/random" -qO- | jshon -e value -e joke -u }
# Python function
if [ -d "${PYENV_ROOT}" ]; then
    # uninstall package with dependencies
    pip-uninstall() {
        for dep in $(pip show $1 | grep Requires | sed 's/Requires: //g; s/,//g') ; do pip uninstall -y $dep ; done
        pip uninstall -y $1
    }
fi
# Override default behaviour for ssh/scp hosts completion.
# list only entries in ~/.ssh/config.d/* (OpenSSH >= 7.3) or ~/.ssh/config (prior to 7.3), not in /etc/hosts
# @see: https://serverfault.com/questions/170346/how-to-edit-command-completion-for-ssh-on-zsh
h=()
if [[ -r ~/.ssh/config.d ]]; then
    h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config.d/*)"}:#Host *}#Host }:#*[*?]*})
elif [[ -r ~/.ssh/config ]]; then
    h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ $#h -gt 0 ]]; then
    zstyle ':completion::complete:scp:*' hosts $h
    zstyle ':completion::complete:ssh:*' hosts $h
fi