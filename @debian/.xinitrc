#!/usr/bin/env sh

# In the Debian system, what many people traditionally put in the .xinitrc 
# should go in .xsession instead
# Read also: https://www.sitepoint.com/understanding-nix-login-scripts

# Executed in this order:
# .xinitrc > xsessionrc > xprofile > xsession

# Unclutter home folder of theses x files by changing vars from /etc/X11/Xsession
# USRRESOURCES=$XDG_CONFIG_HOME/x/Xresources
# USERXSESSION=$XDG_CONFIG_HOME/x/xsession
# USERXSESSIONRC=$XDG_CONFIG_HOME/x/xsessionrc
# ERRFILE=$XDG_CACHE_HOME/xsession-errors

# Comment lines below in /etc/X11/Xsession.d/20x11-common_process-args
# to avoid to be prompt for a not found WM alias
# else
#   message "unable to launch \"$1\" X session ---" \
#           "\"$1\" not found; falling back to default session."

# Cleanup the log file before running anything.
cat /dev/null > "$XDG_CACHE_HOME"/xsession-errors

# xinit [i3|bsp] (see $XDG_CONFIG_HOME/x/xsession)
export WM=$1

# Global xinitrc file, used by all X sessions started by xinit (startx)
# The only thing it does is source /etc/X11/Xsession
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
