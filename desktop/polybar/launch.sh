#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
sleep 0.5

echo "---" | tee -a /tmp/polybar.log

# Laptop
MONITOR=eDP-1 polybar mainbar 2>&1 | tee -a /tmp/polybar.log & disown

# External monitor 1
MONITOR=DP-1-0 polybar sidebar2 2>&1 | tee -a /tmp/polybar.log & disown

# External monitor 2
MONITOR=HDMI-1 polybar sidebar2 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
