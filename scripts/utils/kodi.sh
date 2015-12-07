#!/bin/bash
# Launch Kodi in windowed mode, then use wmctrl to remove the titlebar

# Select display 1
DISPLAY=:0.0

# Start Kodi without blocking this script
kodi &

# Wait for the Kodi window to appear
status=0
while [ $status -eq 0 ]
do
  sleep 3
  status=`wmctrl -x -l | grep "Kodi" | wc -l | awk '{print $1}'`
done

# Force Kodi window to fullscreen
wmctrl -x -r Kodi.Kodi -b toggle,fullscreen