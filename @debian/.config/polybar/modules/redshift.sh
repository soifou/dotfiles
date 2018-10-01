#!/bin/bash

# Import colors from Xresources (pywal required)
. "$HOME/.cache/wal/colors.sh"

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

pgrep -x redshift &> /dev/null
if [[ $? -eq 0 ]]; then
    temp=$(redshift -p 2>/dev/null | grep temp | cut -d' ' -f3)
    temp=${temp//K/}
fi

# OPTIONAL: Append ' ${temp}K' after $icon
if [[ -z $temp ]]; then
    echo "%{F$color8}$icon"       # Greyed out (not running)
elif [[ $temp -ge 4000 ]]; then
    echo "%{F$color12}$icon"       # Blue
elif [[ $temp -ge 3000 ]]; then
    echo "%{F$color11}$icon"       # Yellow
else
    echo "%{F$color1}$icon"       # Orange
fi
