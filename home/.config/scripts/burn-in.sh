#!/usr/bin/env bash

GAPS_IN_SMALL=1
GAPS_OUT_SMALL=3
GAPS_IN_LARGE=3
GAPS_OUT_LARGE=6

switch() {
  if ! hyprctl monitors | grep -q '^Monitor eDP-1'; then
    exit 0
  fi

  ~/.config/scripts/hyproled.sh -a 0:0:2880:67 -s -m 0

  current_in=$(hyprctl -j getoption general:gaps_in | jq -r '.css' | awk '{print $1}')
  current_out=$(hyprctl -j getoption general:gaps_out | jq -r '.css' | awk '{print $1}')

  if [[ "$current_in" -eq $GAPS_IN_SMALL && "$current_out" -eq $GAPS_OUT_SMALL ]]; then
    hyprctl eval "hl.config({ general = { gaps_in = $GAPS_IN_LARGE, gaps_out = $GAPS_OUT_LARGE } })"
  else
    hyprctl eval "hl.config({ general = { gaps_in = $GAPS_IN_SMALL, gaps_out = $GAPS_OUT_SMALL } })"
  fi
}

disable() {
  hyprctl eval "hl.config({ general = { gaps_in = $GAPS_IN_LARGE, gaps_out = $GAPS_OUT_LARGE } })"
}

case "$1" in
switch)
  switch
  ;;
disable)
  disable
  ;;
esac
