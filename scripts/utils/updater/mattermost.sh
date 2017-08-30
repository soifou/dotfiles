#!/bin/bash

print_success() {
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

lastReleasesUrl="https://github.com/mattermost/desktop/releases.atom"
lastReleaseCache="/tmp/mattermost-last-release"
semanticVersionPattern="[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}"

# we get the tar.gz instead of deb to get the version number
# "libnotify-bin" package can be installed
tmp_filepath="/tmp/mattermost-latest.tar.gz"
install_dir="/opt"

# @TODO: cannot get the version from the bin???
currentVersion=$(find $install_dir -maxdepth 1 -type d | grep mattermost-desktop | awk -F- '{print $3}')
if [ "$currentVersion" = "" ]; then
    currentVersion="0.0.0"
fi

if [ ! -f $lastReleaseCache ] || [ "$(( $(date +"%s") - $(stat -c "%Y" $lastReleaseCache) ))" -gt "86400" ]; then
    echo 'Checking latest Mattermost Desktop version...'
    wget -q -O- $lastReleasesUrl | \
        egrep -m1 -o "/mattermost/desktop/releases/tag/v$semanticVersionPattern\"" | \
        egrep -o "$semanticVersionPattern" \
        > $lastReleaseCache
fi

latestVersion=$(cat $lastReleaseCache)

if [ "$latestVersion" != "$currentVersion" ]; then
    echo "Updating Mattermost Desktop v${currentVersion} to v${latestVersion}"
    wget -q --show-progress --progress=bar:force \
        https://releases.mattermost.com/desktop/${latestVersion}/mattermost-desktop-${latestVersion}-linux-x64.tar.gz \
        -O $tmp_filepath && \
    sudo tar -zxf $tmp_filepath -C $install_dir && \
    rm $tmp_filepath
    print_success "Mattermost Desktop has been upgraded to v$latestVersion"
else
    echo "Already up-to-date."
fi