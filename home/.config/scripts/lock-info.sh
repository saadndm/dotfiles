#!/usr/bin/env bash

battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity)

battery_status=$(cat /sys/class/power_supply/BAT1/status)

battery_icons=("" "" "" "" "" "" "")

charging_icon=""

icon_index=$(((battery_percentage * ${#battery_icons[@]}) / 101))

battery_icon=${battery_icons[icon_index]}

if [ "$battery_status" = "Charging" ]; then
  battery_icon="$charging_icon"
fi

echo "$battery_percentage% <span font='Font Awesome 6 Pro Solid'>$battery_icon</span>"
