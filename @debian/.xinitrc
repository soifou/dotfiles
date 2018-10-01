#!/bin/sh

# Merge in defaults and keymaps
if [ -f /etc/X11/xinit/.Xresources ]; then
    xrdb -merge /etc/X11/xinit/.Xresources
fi
if [ -f /etc/X11/xinit/.Xmodmap ]; then
    xmodmap /etc/X11/xinit/.Xmodmap
fi
if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi
if [ -f "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi

# Launch dbus
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Source xprofile
#[ -f $HOME/.xprofile ] && . $HOME/.xprofile
[ -f $HOME/.xsessionrc ] && . $HOME/.xsessionrc

# Start i3
if [ -f /usr/bin/i3 ]; then
    exec i3
fi
