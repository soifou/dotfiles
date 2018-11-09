#!/bin/bash

# Import colors from Xresources (pywal required)
. "$HOME/.cache/wal/colors.sh"

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""
temp=$(redshift -l "$MY_LATLONG" -p 2>/dev/null | grep temp | cut -d' ' -f3 | rev | cut -c 2- | rev)

if [[ -z $temp ]]; then
    echo "%{F$color8}$icon  ${temp}K"       # Greyed out (not running)
elif [[ $temp -ge 6000 ]]; then
    echo "%{F$color12}$icon  ${temp}K"       # Blue
elif [[ $temp -ge 4000 ]]; then
    echo "%{F$color11}$icon  ${temp}K"       # Yellow
else
    echo "%{F$color1}$icon  ${temp}K"       # Orange
fi

# Adjust redshift manually
"$HOME/.bin/brightness" 1
