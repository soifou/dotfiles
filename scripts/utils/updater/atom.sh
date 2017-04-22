#!/bin/bash

print_success() {
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

lastReleasesUrl="https://github.com/atom/atom/releases.atom"
lastReleaseCache="/tmp/atom-last-release"
semanticVersionPattern="v[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}"
tmp_filepath="/tmp/atom-amd64.deb"

if [ -f '/usr/bin/atom' ]; then
    currentVersion="v$(atom --version | grep Atom | awk -F: '{print $2}' | tr -d '[:space:]')"
else
    currentVersion="v0.0.0"
fi

if [ ! -f $lastReleaseCache ] || [ "$(( $(date +"%s") - $(stat -c "%Y" $lastReleaseCache) ))" -gt "86400" ]; then
    echo 'Checking latest atom version...'
    # @NOTE: we put a double quote of the end of first grep to get only latest stable release
    wget -q -O- $lastReleasesUrl | \
        egrep -m1 -o "/atom/atom/releases/tag/$semanticVersionPattern\"" | \
        egrep -o "$semanticVersionPattern" \
        > $lastReleaseCache
fi

latestVersion=$(cat $lastReleaseCache)

if [ "$latestVersion" != "$currentVersion" ]; then
    echo "Updating atom ${currentVersion} to ${latestVersion}"
    wget -q --show-progress --progress=bar:force \
        https://github.com/atom/atom/releases/download/${latestVersion}/atom-amd64.deb \
        -O $tmp_filepath && \
    sudo dpkg -i $tmp_filepath && \
    rm $tmp_filepath
    apm upgrade --confirm false
    print_success "Atom has been upgraded to $latestVersion"
else
    echo "Already up-to-date."
fi