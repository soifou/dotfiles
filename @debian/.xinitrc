#!/bin/sh

# ~/.xinitrc for Debian
# https://manpages.debian.org/current/x11-common/Xsession.5.en.html
# https://www.sitepoint.com/understanding-nix-login-scripts

cat /dev/null > "$HOME/.xsession-errors"

[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
