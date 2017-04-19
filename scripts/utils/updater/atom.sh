#!/bin/bash

print_success() {
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

atom_version=`atom --version | grep Atom | awk -F: '{print $2}' | xargs`
latest_tag=`git ls-remote --tags https://github.com/atom/atom.git | tail -n 1 | cut -f 2`
latest=`basename $latest_tag`
latest=`echo $latest | sed 's/^v//'`
tmp_filepath="/tmp/atom-amd64.deb"

if [ "$atom_version" == "$latest" ]; then
    echo "Already up-to-date."
    exit 0
fi

echo "Updating Atom v$atom_version to v$latest..."
wget -q --show-progress --progress=bar:force \
    https://github.com/atom/atom/releases/download/v$latest/atom-amd64.deb \
    -O $tmp_filepath
sudo dpkg -i $tmp_filepath
rm $tmp_filepath
apm upgrade --confirm false
print_success "Atom has been upgraded to v$latest"