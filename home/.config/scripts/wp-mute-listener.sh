#!/usr/bin/env bash

~/.config/scripts/wp-mute-listener | while read -r state; do
  if [[ "$state" == "muted" ]]; then
    echo 1 | sudo tee /sys/class/leds/platform::mute/brightness >/dev/null
  elif [[ "$state" == "unmuted" ]]; then
    echo 0 | sudo tee /sys/class/leds/platform::mute/brightness >/dev/null
  fi
done
