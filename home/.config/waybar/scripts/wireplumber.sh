#!/usr/bin/env bash

prev_muted=""

echo "DEBUG: Exiting get_volume_info" >&2

get_volume_info() {
  in_sinks=0
  sink_line=""
  while IFS= read -r line; do
    [[ $line == *Sinks:* ]] && {
      in_sinks=1
      continue
    }
    ((in_sinks)) && [[ $line == *Sources:* ]] && break
    ((in_sinks)) && [[ $line == *\** ]] && {
      sink_line=$line
      break
    }
  done < <(wpctl status)

  if [[ $sink_line =~ \[vol:\ ([0-9]+\.[0-9]+)(\ MUTED)?\] ]]; then
    vol_raw=${BASH_REMATCH[1]}
    ((${#BASH_REMATCH[2]})) && muted=1 || muted=0
  else
    echo "N/A"
    return 1
  fi

  # Fix broken mute led on lenovo laptop
  [[ $muted != $prev_muted ]] && {
    echo "$muted" | sudo tee /sys/class/leds/platform::mute/brightness >/dev/null
    prev_muted=$muted
  }

  tmp=${vol_raw/./}
  volume=$((10#$tmp))

  if [[ $sink_line == *"Speaker"* ]]; then
    icon=""
  elif [[ $sink_line == *"soundcore Liberty 4 NC"* ]]; then
    icon="ᖳᖰ"
  elif [[ $sink_line == *"WH-1000XM4"* ]]; then
    icon=""
  else
    icon=""
  fi

  if ((muted)); then
    printf '<span foreground="#f38ba8">%d%% <span font="Font Awesome 6 Pro Solid">%s</span></span>\n' \
      "$volume" "$icon"
  else
    printf '<span foreground="#cba6f7">%d%% <span font="Font Awesome 6 Pro Solid">%s</span></span>\n' \
      "$volume" "$icon"
  fi
}

pactl subscribe | while read -r event; do
  if [[ $event == *"sink"* ]] || [[ $event == *"node"* ]]; then
    get_volume_info
  fi
done
