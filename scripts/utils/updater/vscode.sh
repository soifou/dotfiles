#!/bin/bash

print_success() {
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

lastReleasesUrl="https://github.com/Microsoft/vscode/releases.atom"
lastReleaseCache="/tmp/vscode-last-release"
semanticVersionPattern="[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}"
tmp_filepath="/tmp/vscode-latest-amd64.deb"

if [ -f '/usr/bin/code' ]; then
    currentVersion=$(code -v | egrep -o "$semanticVersionPattern")
else
    currentVersion="0.0.0"
fi

if [ ! -f $lastReleaseCache ] || [ "$(( $(date +"%s") - $(stat -c "%Y" $lastReleaseCache) ))" -gt "86400" ]; then
    echo 'Checking latest VSCode version...'
    # @NOTE: we put a double quote of the end of first grep to get only latest stable release
    wget -q -O- $lastReleasesUrl | \
        egrep -m1 -o "/Microsoft/vscode/releases/tag/$semanticVersionPattern\"" | \
        egrep -o "$semanticVersionPattern" \
        > $lastReleaseCache
fi

latestVersion=$(cat $lastReleaseCache)

if [ "$latestVersion" != "$currentVersion" ]; then
    echo "Updating VSCode v${currentVersion} to v${latestVersion}"
    wget -q --show-progress --progress=bar:force \
        https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable \
        -O $tmp_filepath && \
    sudo dpkg -i $tmp_filepath && \
    rm $tmp_filepath
    print_success "VSCode has been upgraded to v$latestVersion"
else
    echo "Already up-to-date."
fi