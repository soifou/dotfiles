#!/usr/bin/env sh

# xinitrc for Debian
# man Xsession
# https://www.sitepoint.com/understanding-nix-login-scripts
# Executed in this order:
# XINITRC > XSESSIONRC > XPROFILE > XSESSION

# To unclutter home folder of those x files, change vars from /etc/X11/Xsession
# USRRESOURCES=$XDG_CONFIG_HOME/x/Xresources
# USERXSESSION=$XDG_CONFIG_HOME/x/xsession
# USERXSESSIONRC=$XDG_CONFIG_HOME/x/xsessionrc
# ERRFILE=$XDG_CACHE_HOME/xsession-errors

# Cleanup the log file before running anything.
cat /dev/null > "$XDG_CACHE_HOME"/xsession-errors

# Global xinitrc file, used by all X sessions started by xinit (startx)
# The only thing it does is source /etc/X11/Xsession
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
