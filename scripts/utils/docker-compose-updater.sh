#!/bin/bash

# Docker-compose updater for lazy dude
# Initial author: https://gist.github.com/xarem/3ce7f1aaad9b3ca9783b

print_success() {
    printf "\e[0;32m  [✔] $1\e[0m\n"
}
print_info() {
    printf "\e[0;35m $1\e[0m\n"
}

lastReleasesUrl="https://github.com/docker/compose/releases.atom"
lastReleaseCache="/tmp/docker-compose-last-release"

if [ -f '/usr/local/bin/docker-compose' ]; then
    currentDockerComposeVersion=$(docker-compose -v | egrep -o '([0-9]\.[0-9]\.[0-9])')
else
    currentDockerComposeVersion="0.0.0"
fi

if [ ! -f $lastReleaseCache ] || [ "$(( $(date +"%s") - $(stat -c "%Y" $lastReleaseCache) ))" -gt "86400" ]; then
    print_info 'Checking latest docker-compose version...'
    wget -q -O- $lastReleasesUrl | \
        egrep -m1 -o '/docker/compose/releases/tag/([0-9]\.[0-9]\.[0-9])' | \
        egrep -o '([0-9]\.[0-9]\.[0-9])' \
            > $lastReleaseCache
fi

latestDockerComposeVersion=$(cat $lastReleaseCache)

if [ $latestDockerComposeVersion != $currentDockerComposeVersion ]; then
    print_info "Updating docker-compose v${currentDockerComposeVersion} to v${latestDockerComposeVersion}"
    curl -L https://github.com/docker/compose/releases/download/${latestDockerComposeVersion}/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose && \
        mv /tmp/docker-compose /usr/local/bin && \
        chmod +x /usr/local/bin/docker-compose && \
        # chown root:root /usr/local/bin/docker-compose
    print_success 'docker-compose is now up to date :)'
else
    print_info 'docker-compose is already up to date'
fi