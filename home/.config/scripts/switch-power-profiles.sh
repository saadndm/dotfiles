#!/usr/bin/env bash

current=$(busctl get-property net.hadess.PowerProfiles /net/hadess/PowerProfiles net.hadess.PowerProfiles ActiveProfile | awk -F\" '{print $2}')

profiles=("power-saver" "balanced" "performance")

for i in "${!profiles[@]}"; do
  if [[ "${profiles[$i]}" == "$current" ]]; then
    idx=$i
    break
  fi
done

next=$(((idx + 1) % ${#profiles[@]}))

busctl set-property net.hadess.PowerProfiles /net/hadess/PowerProfiles net.hadess.PowerProfiles ActiveProfile s "${profiles[$next]}"
echo "Switched from $current → ${profiles[$next]}"
