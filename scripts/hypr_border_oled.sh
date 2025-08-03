#!/usr/bin/env bash

HYPR_CONFIG="$HOME/.config/hypr/hyprland.conf"

# Original border configuration (30 degrees)
ORIGINAL_BORDER="rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 30deg"
# Properly mirrored border configuration (swapped colors, same angle)
MIRROR_BORDER="rgb(24273A) rgb(8aadf4) rgb(8aadf4) rgb(24273A) 30deg"

# Check which configuration is currently active
if grep -q "col.active_border = $ORIGINAL_BORDER" "$HYPR_CONFIG"; then
  # Switch to mirror
  sed -i "s|col.active_border = $ORIGINAL_BORDER|col.active_border = $MIRROR_BORDER|g" "$HYPR_CONFIG"
  echo "Switched to mirrored border"
elif grep -q "col.active_border = $MIRROR_BORDER" "$HYPR_CONFIG"; then
  # Switch back to original
  sed -i "s|col.active_border = $MIRROR_BORDER|col.active_border = $ORIGINAL_BORDER|g" "$HYPR_CONFIG"
  echo "Switched to original border"
else
  echo "Border configuration not found or doesn't match expected patterns"
fi
