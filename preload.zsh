PATH=/usr/local/bin:/usr/sbin:/usr/bin:$HOME/.composer/vendor/bin:/sbin:/bin:/usr/games

if [[ `uname` == "Linux" ]]; then
    # Support more than 256 colors
    export TERM="xterm-256color"
fi