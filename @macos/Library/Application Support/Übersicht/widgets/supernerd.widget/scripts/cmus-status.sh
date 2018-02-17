#!/bin/sh

print_song() {
    status=$(/usr/local/bin/cmus-remote -Q | grep status | awk -F\  '{print $2}')
    if [[ $status == 'stopped' ]]; then
        echo "No playing"
    else
        remote=$(/usr/local/bin/cmus-remote -Q)
        song=$(echo "$remote" | grep tag | head -n 3 | sort -r | cut -d ' ' -f 3- )
        # artist=$(echo "$song" | head -n 2 | tail -n 1)
        # title=$(echo "$song" | head -n 1 )
        echo "$song"
    fi
}

cmus=$(pgrep cmus || echo 0)
if [ "$cmus" -ne 0 ]
then
    print_song
else
    echo "Not running"
fi
