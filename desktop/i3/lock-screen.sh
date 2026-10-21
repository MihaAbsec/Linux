#!/usr/bin/env bash
# Keep the locker in the foreground for xss-lock's suspend inhibition.
if command -v betterlockscreen >/dev/null 2>&1; then
    exec betterlockscreen -l dimblur
fi
exec i3lock --nofork --color=1e2430
