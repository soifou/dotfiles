#!/bin/bash

# This script can adjust both brightness and temperature screen from redshift.
# We not rely on xrandr nor xbacklight to set brightness because of redshift.
# Put this configuration in polybar modules
# ---
# [module/redshift]
# type = custom/script
# interval = 5
# exec = ~/.config/polybar/modules/redshift.sh --temp
# scroll-up = ~/.config/polybar/modules/redshift.sh --up
# scroll-down = ~/.config/polybar/modules/redshift.sh --down

tmpfile='/tmp/polybar-modules-redshift.tmp'
if [ ! -f $tmpfile ]; then
    touch $tmpfile
    echo "1.0" > $tmpfile
fi
brightness=$(cat "$tmpfile")

# Adjust redshift manually
adjustBrightness() {
    redshift -P -O $(getTemp) -g 1.0 -m randr -b $brightness
}

# -->
getTemp() {
    echo $(redshift -l "$OPENWEATHERMAP_LAT:$OPENWEATHERMAP_LONG" -p 2>/dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")
}

brightnessUp() {
    brightness=$(echo "$brightness+.1" | bc -l)
    result=$(echo "$brightness <= 1.0" | bc -l)
    [ "$result" = '1' ] && \
        echo "$brightness" > $tmpfile && \
        adjustBrightness
}
brightnessDown() {
    brightness=$(echo "$brightness-.1" | bc -l)
    result=$(echo "$brightness > 0.0" | bc -l)
    [ "$result" = '1' ] && \
        echo "$brightness" > $tmpfile && \
        adjustBrightness

}
adjustTemp() {
    # Import colors from Xresources (pywal required)
    . "$HOME/.cache/wal/colors.sh"
    # Specifying the icon(s) in the script
    # This allows us to change its appearance conditionally
    icon=""
    temp=$(getTemp)

    if [[ -z $temp ]]; then
        echo "%{F$color8}$icon ${temp}K" # Greyed out (not running)
    elif [[ $temp -ge 6000 ]]; then
        echo "%{F$color12}$icon ${temp}K" # Blue
    elif [[ $temp -ge 4000 ]]; then
        echo "%{F$color1}$icon ${temp}K" # Yellow
    else
        echo "%{F$color1}$icon ${temp}K" # Orange
    fi

    adjustBrightness
}

case "$1" in
    --up)
        brightnessUp
    ;;
    --down)
        brightnessDown
    ;;
    --temp)
        adjustTemp
    ;;
esac
