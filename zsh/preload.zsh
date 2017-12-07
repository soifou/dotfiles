PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

if [[ `uname` == "Linux" ]]; then
    # Support more than 256 colors
    export TERM="xterm-256color"
fi