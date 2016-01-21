#!/bin/bash

COMMAND=$1
URL="dict://dict.org"

usage() {
    echo "usage: $(basename $0) [d|m|l|s] [ARGUMENTS]...
    d WORD [DATABASE]
    m WORD [DATABASE] [STRATEGY]"
}

run() {
    URL=$1
    shift
    for i in $@; do
        URL="$URL:$i"
    done
    curl $URL
}

define() {
    run "$URL/d" $@
}

match() {
    run "$URL/m" $@
}

case "$1" in
    "d")
        shift
        define $@
        ;;
    "m")
        shift
        match $@
        ;;
    "l")
        run "$URL/show:databases"
        ;;
    "s")
        run "$URL/show:strategies"
        ;;
    *)
        usage
        exit 1
        ;;
esac

exit 0