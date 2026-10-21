#!/usr/bin/env bash
set -euo pipefail
yay -S --needed betterlockscreen
betterlockscreen -u "$HOME/wallpapers/wallpaper.jpg" --fx dimblur
i3-msg reload
i3-msg 'exec --no-startup-id ~/.config/i3/start-screen-lock.sh'
echo "Zaklep je pripravljen. Preizkusi Mod+Shift+X."
