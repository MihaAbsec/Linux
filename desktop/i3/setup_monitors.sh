#!/bin/bash

# ============================================================
# Dynamic monitor setup for i3 + xrandr
#
# Samsung LS24AG30 -> primary, 1920x1080 @ 144 Hz
# Laptop           -> right of Samsung, 1920x1080 @ 144 Hz
# Gigabyte Q27P1B  -> right of laptop, 2560x1440 @ 60 Hz
# ============================================================


# ------------------------------------------------------------
# Find monitor output by EDID
# ------------------------------------------------------------

get_output_by_edid() {
    local search="$1"

    xrandr --props | awk -v search="$search" '
        /^[^[:space:]].* connected/ {
            output=$1
            in_edid=0
            edid=""
        }

        /^[[:space:]]+EDID:/ {
            in_edid=1
            edid=""
            next
        }

        in_edid && /^[[:space:]]+[0-9a-fA-F]+$/ {
            gsub(/[[:space:]]/, "", $0)
            edid=edid $0
            next
        }

        in_edid && !/^[[:space:]]+[0-9a-fA-F]+$/ {
            if (index(edid, search) > 0) {
                print output
                exit
            }

            in_edid=0
        }
    '
}


# ------------------------------------------------------------
# Identify monitors
# ------------------------------------------------------------

# Samsung LS24AG30
# EDID contains ASCII:
# 4c 53 32 34 41 47 33 30 78
SAMSUNG=$(get_output_by_edid "4c5332344147333078")

# Gigabyte Q27P1B
# EDID contains ASCII:
# 51 32 37 50 31 42
GIGABYTE=$(get_output_by_edid "513237503142")

# Laptop display
LAPTOP="eDP-1"


# ------------------------------------------------------------
# Check monitors
# ------------------------------------------------------------

if [ -z "$SAMSUNG" ]; then
    echo "ERROR: Samsung LS24AG30 not found!"
    exit 1
fi

if [ -z "$GIGABYTE" ]; then
    echo "ERROR: Gigabyte Q27P1B not found!"
    exit 1
fi

if ! xrandr --query | grep -q "^${LAPTOP} connected"; then
    echo "ERROR: Laptop display $LAPTOP not found!"
    exit 1
fi


# ------------------------------------------------------------
# Give X/i3 a moment after startup/restart
# ------------------------------------------------------------

sleep 0.5


# ------------------------------------------------------------
# Apply the EXACT SAME layout as your working command
# ------------------------------------------------------------

xrandr \
    --output "$SAMSUNG" \
        --rate 144 \
        --auto \
        --primary \
    --output "$LAPTOP" \
        --auto \
        --right-of "$SAMSUNG" \
    --output "$GIGABYTE" \
        --mode 2560x1440 \
        --rate 60 \
        --dpi 120 \
        --right-of "$LAPTOP"


# ------------------------------------------------------------
# Print detected outputs
# ------------------------------------------------------------

echo "Monitor setup:"
echo "  Samsung  -> $SAMSUNG"
echo "  Laptop   -> $LAPTOP"
echo "  Gigabyte -> $GIGABYTE"
