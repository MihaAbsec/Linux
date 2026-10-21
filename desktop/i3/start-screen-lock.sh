#!/usr/bin/env bash
set -eu
# Starting or restarting i3 should restore the watcher without duplicates.
if pgrep -u "$UID" -x xss-lock >/dev/null; then
    exit 0
fi
exec xss-lock --transfer-sleep-lock -- "$HOME/.config/i3/lock-screen.sh"
