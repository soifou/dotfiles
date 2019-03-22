#!/bin/sh

# Adjust both brightness and temperature screen from redshift (no daemon required).
# We can't rely on xrandr nor xbacklight to adjust brightness while redshift is running.
# see https://github.com/jonls/redshift/issues/175

# Using as a polybar module
# ---
# [module/redshift]
# type = custom/script
# interval = 5
# exec = ~/.config/polybar/modules/redshift.sh --temp
# scroll-up = ~/.config/polybar/modules/redshift.sh --up
# scroll-down = ~/.config/polybar/modules/redshift.sh --down
# click-left = ~/.config/polybar/modules/redshift.sh --toggle

# Configuration
icon=""
temperatures="6500:2700"
lat="$OPENWEATHERMAP_LAT"
long="$OPENWEATHERMAP_LONG"

tmpfile='/tmp/polybar-modules-redshift.tmp'
if [ ! -f $tmpfile ]; then
    touch $tmpfile
    echo "1.0" > $tmpfile
fi
brightness=$(cat "$tmpfile")

# Adjust redshift manually
setBrightness() {
    redshift -P -O "$(getTemp)" -g 1.0 -m randr -b "$brightness"
}

# Get current temperature according to geocode
getTemp() {
    echo $(redshift -t $temperatures -l "$lat:$long" -p 2>/dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")
}

# Import colors from Xresources
getColors() {
    # From Pywal
    if [ -f "$HOME/.cache/wal/colors.sh" ]; then
        # shellcheck source=/dev/null
        . "$HOME/.cache/wal/colors.sh"
    # From Xressources
    else
        color15=$(xrdb -query | grep -e '*color15' | awk -F: '{print $2}' | xargs)
        color4=$(xrdb -query | grep '*color4' | awk -F: '{print $2}' | xargs)
        color3=$(xrdb -query | grep '*color3' | awk -F: '{print $2}' | xargs)
        color1=$(xrdb -query | grep '*color1' | awk -F: '{print $2}' | xargs)
    fi
}

brightnessUp() {
    brightness=$(echo "$brightness+.1" | bc -l)
    result=$(echo "$brightness <= 1.0" | bc -l)
    [ "$result" = '1' ] && \
        echo "$brightness" > $tmpfile && \
        setBrightness
}
brightnessDown() {
    brightness=$(echo "$brightness-.1" | bc -l)
    result=$(echo "$brightness > 0.0" | bc -l)
    [ "$result" = '1' ] && \
        echo "$brightness" > $tmpfile && \
        setBrightness

}
setTemp() {
    getColors

    temp=$(getTemp)
    if [ -z "$temp" ]; then
        echo "%{F$color15}$icon ${temp}K" # Greyed out (not running)
    elif [ "$temp" -ge 6000 ]; then
        echo "%{F$color4}$icon ${temp}K" # Blue
    elif [ "$temp" -ge 4000 ]; then
        echo "%{F$color3}$icon ${temp}K" # Yellow
    else
        echo "%{F$color1}$icon ${temp}K" # Red
    fi

    setBrightness
}

toggleReset() {
    if [ -f $tmpfile.lock ]; then
        rm -f $tmpfile.lock
        setTemp
    else
        redshift -x
        touch $tmpfile.lock
        echo "no redshift"
    fi
}

case "$1" in
    --up)
        [ -f $tmpfile.lock ] && exit 0
        brightnessUp
    ;;
    --down)
        [ -f $tmpfile.lock ] && exit 0
        brightnessDown
    ;;
    --temp)
        if [ -f $tmpfile.lock ]; then
            echo "no redshift"
            exit 0
        else
            setTemp
        fi
    ;;
    --toggle)
        toggleReset
    ;;
    *)
        echo "Adjust both brightness and temperature screen from redshift (no daemon required)." >&2
        echo "" >&2
        echo "--up          Set screen brightness up to .1" >&2
        echo "--down        Set screen brightness lower to .1" >&2
        echo "--temp        Adjust correct temperature according to your geocode" >&2
        echo "--toggle      Enable/disable the script" >&2
        exit
    ;;
esac
