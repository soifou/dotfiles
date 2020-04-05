#!/usr/bin/env sh

# ~/.xinitrc for Debian
# man Xsession
# https://www.sitepoint.com/understanding-nix-login-scripts

cat /dev/null > "$HOME/.xsession-errors"

[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
