#!/usr/bin/env bash
# When DP-1 appears ► disable eDP-1 and use DP-1
# When DP-1 disappears ► re-enable eDP-1

SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

enable_laptop() {
  hyprctl keyword monitor "eDP-1,2880x1800@120,auto,2,vrr,1,bitdepth,10"
}

disable_laptop_enable_hdmi() {
  hyprctl keyword monitor "eDP-1,disable"
  hyprctl keyword monitor "DP-1,2560x1440@180,auto,1.6,vrr,1,bitdepth,10"
}

if hyprctl monitors | grep -q "DP-1"; then
  disable_laptop_enable_hdmi
else
  enable_laptop
fi

socat -U - UNIX-CONNECT:"$SOCK" | while read -r ev; do
  case "$ev" in
  monitoradded*,DP-1* | monitoraddedv2*,DP-1*)
    disable_laptop_enable_hdmi
    ;;
  monitorremoved*,DP-1* | monitorremovedv2*,DP-1*)
    enable_laptop
    ;;
  esac
done
