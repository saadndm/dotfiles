#!/usr/bin/env bash
set -euo pipefail

MON_HDMI="HDMI-A-1"
MON_LAP="eDP-1"

monitors=$(hyprctl monitors all)

if grep -q "^Monitor $MON_HDMI " <<<"$monitors"; then
  echo "Detected $MON_HDMI → turning OFF $MON_LAP"
  hyprctl keyword monitor "eDP-1,disable"
else
  echo "$MON_HDMI not present → turning ON $MON_LAP"
  hyprctl keyword monitor "eDP-1,2880x1800@120,auto,2,vrr,1"
fi
