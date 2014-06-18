#!/bin/bash
############################
# This script backup current User sublime settings and creates symlinks from dotfiles/sublime
############################

dir=~/dotfiles/sublime
defaultDir=~/.config/sublime-text-3/Packages
userDir=User
bckDir=User_old
plugins="open_browser"

# USER, EDITOR, PACKAGE & PLUGINS SETTINGS
cd $defaultDir
if [ ! -d "$defaultDir/$bckDir" ]; then
    echo "create backup folder : $defaultDir/$bckDir"
    mkdir $bckDir/
fi

for f in $defaultDir/$userDir/*.sublime-*; do
    # remember to quote it or spaces may misbehave
    filename=$(basename "$f")
    filePath="$defaultDir/User/$filename"

    symbolic=$(test -h "$filePath" && echo "true" || echo "false")
    if [ "$symbolic" == "false" ]; then
        # backup file
        echo "Moving existing $filename config to old directory"
        mv "$f" $defaultDir/$bckDir/
        echo "Creating symlink $filename from dotfiles repo"
        ln -s "$dir/User/$filename" "$defaultDir/User/$filename"
    else
        echo "$filename is already symlinked, skip !"
    fi
done

# CUSTOM PLUGINS
for plugin in $plugins; do
    filename=$plugin'.py'
    filePath=$defaultDir/$plugin/$filename

    if [ ! -d "$defaultDir/$plugin" ]; then
        mkdir "$defaultDir/$plugin"
    else
        rm $filePath
    fi

    symbolic=$(test -h "$filePath/$filename" && echo "true" || echo "false")
    if [ $symbolic == "false" ]; then
        echo 'Create symlinked plugin <'$plugin'>'
        ln -s $dir/$plugin/$filename $filePath
    fi
done