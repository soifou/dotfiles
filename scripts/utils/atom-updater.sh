#!/bin/bash

atom_version=`atom --version | grep Atom | awk -F: '{print $2}' | xargs`
latest_tag=`git ls-remote --tags https://github.com/atom/atom.git | tail -n 1 | cut -f 2`
latest=`basename $latest_tag`
latest=`echo $latest | sed 's/^v//'`

echo 'Checking atom version...'
echo '  Current version : ' $atom_version
echo '  Latest version  : ' $latest

if [ "$atom_version" == "$latest" ]; then
    echo "  > Latest version is already installed.  Exiting..." &&
    exit 0
fi

echo 'Upgrading atom...'
wget https://github.com/atom/atom/releases/download/v$latest/atom-amd64.deb -O /tmp/atom-amd64.deb
sudo dpkg -i /tmp/atom-amd64.deb
rm /tmp/atom-amd64.deb
echo "  > Atom v$latest is set to the latest version. Exiting..."