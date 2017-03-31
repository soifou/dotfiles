#!/bin/bash

# Docker-compose updater for lazy dude
# Initial author: https://gist.github.com/xarem/3ce7f1aaad9b3ca9783b
# Add some bash colors ouput and fix semantic versioning

print_success() {
    printf "\e[0;32m  [✔] $1\e[0m\n"
}
print_info() {
    printf "\e[0;35m $1\e[0m\n"
}

lastReleasesUrl="https://github.com/docker/compose/releases.atom"
lastReleaseCache="/tmp/docker-compose-last-release"
semanticVersionPattern="[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}"

if [ -f '/usr/local/bin/docker-compose' ]; then
    currentDockerComposeVersion=$(docker-compose -v | egrep -o "$semanticVersionPattern")
else
    currentDockerComposeVersion="0.0.0"
fi

if [ ! -f $lastReleaseCache ] || [ "$(( $(date +"%s") - $(stat -c "%Y" $lastReleaseCache) ))" -gt "86400" ]; then
    print_info 'Checking latest docker-compose version...'
    # @NOTE: we put a double quote of the end of first grep to get only latest stable release
    wget -q -O- $lastReleasesUrl | \
        egrep -m1 -o "/docker/compose/releases/tag/$semanticVersionPattern\"" | \
        egrep -o "$semanticVersionPattern" \
        > $lastReleaseCache
fi

latestDockerComposeVersion=$(cat $lastReleaseCache)

if [ "$latestDockerComposeVersion" != "$currentDockerComposeVersion" ]; then
    print_info "Updating docker-compose v${currentDockerComposeVersion} to v${latestDockerComposeVersion}"
    curl -L https://github.com/docker/compose/releases/download/${latestDockerComposeVersion}/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose && \
        mv /tmp/docker-compose /usr/local/bin && \
        chmod +x /usr/local/bin/docker-compose && \
    print_success 'docker-compose is now up to date :)'
else
    print_info "docker-compose v$currentDockerComposeVersion is already the latest release"
fi