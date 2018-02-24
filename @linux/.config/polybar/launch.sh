#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar "dark" on all monitors (if any)
if type "xrandr"; then
    # for all connected monitors
    # for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # for the last one connected on the list
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        MONITOR=$m polybar --reload dark &
    done
else
    polybar --reload dark &
fi
