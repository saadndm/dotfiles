#!/usr/bin/env bash
# ~/.config/hypr/auto-monitors.sh
# ------------------------------------------------------------
# When HDMI-A-1 appears ► disable eDP-1 and use HDMI-A-1
# When HDMI-A-1 disappears ► re-enable eDP-1

# Path to Hyprland "events" socket
SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

enable_laptop() {
  # laptop back on, native mode
  hyprctl keyword monitor "eDP-1,2880x1800@120,auto,2,vrr,1,bitdepth,10"
}

disable_laptop_enable_hdmi() {
  # switch everything to HDMI
  hyprctl keyword monitor "eDP-1,disable"
  hyprctl keyword monitor "HDMI-A-1,2560x1440@165,auto,1.6,vrr,1,bitdepth,10"
}

# Read events from Hyprland
socat -U - UNIX-CONNECT:"$SOCK" | while read -r ev; do
  case "$ev" in
  monitoradded*,HDMI-A-1* | monitoraddedv2*,HDMI-A-1*)
    disable_laptop_enable_hdmi
    ;;
  monitorremoved*,HDMI-A-1* | monitorremovedv2*,HDMI-A-1*)
    enable_laptop
    ;;
  esac
done
