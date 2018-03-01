#!/usr/bin/env sh

# Startup script for polybar.
# @NOTE: zsh/fish users have to pass SHELL var to fix "passing env var to custom script not working" issue.
# see: https://github.com/jaagr/polybar/issues/323#issuecomment-292038260


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
        SHELL=$(which sh) MONITOR=$m polybar --reload dark &
    done
else
    SHELL=$(which sh) polybar --reload dark &
fi
