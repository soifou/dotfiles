#!/bin/bash

atom_version=`atom --version`
latest_tag=`git ls-remote --tags https://github.com/atom/atom.git | tail -n 1 | cut -f 2`
latest=`basename $latest_tag`
latest=`echo $latest | sed 's/^v//'`

echo '[Checking atom version...]'
echo '  Current version : ' $atom_version
echo '  Latest version  : ' $latest
echo ''

test "$atom_version" == "$latest" &&
  echo "Latest version is already installed.  Exiting..." &&
  exit 0

echo 'Upgrading atom...'
mkdir -p $HOME/tmp/atom && cd $HOME/tmp/atom
wget https://github.com/atom/atom/releases/download/v$latest/atom-amd64.deb
sudo dpkg -i atom-amd64.deb
rm atom-amd64.deb
echo 'Atom is set to the latest version. Exiting...'