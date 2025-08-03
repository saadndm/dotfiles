#!/usr/bin/env bash
set -euo pipefail

SYSFILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
ACFILE=$(grep -l '^Mains$' /sys/class/power_supply/*/type | head -n1)
AC_ONLINE="${ACFILE%/type}/online"

[[ -e "$SYSFILE" ]] || {
  echo '{"text":"","tooltip":"conservation_mode file not found"}'
  exit 0
}

# ---------------------------------------------------------------------------
# If we were called *to toggle*, do that first and then fall through to the
# normal reporting path so Waybar immediately refreshes.
# ---------------------------------------------------------------------------
if [[ "${1-}" == "toggle" ]]; then
  curr=$(<"$SYSFILE")
  new=$((1 - curr))
  echo "$new" | sudo tee "$SYSFILE" >/dev/null
  # fall through
fi

# ---------------------------------------------------------------------------
# Hide the module completely when the laptop is not on AC power
# ---------------------------------------------------------------------------
if [[ -e "$AC_ONLINE" ]] && [[ $(<"$AC_ONLINE") == "0" ]]; then
  # Printing nothing makes Waybar hide the module
  exit 0
fi

state=$(<"$SYSFILE") # "0" = off, "1" = on

if [[ "$state" == "1" ]]; then # 75 % cap is ACTIVE
  icon=""                     # Font-Awesome “battery three-quarters”
  class="enabled"
  tip="Battery charge capped at 75 % (click to disable)"
else       # cap is OFF
  icon="" # Font-Awesome “bolt”
  class="disabled"
  tip="Charging unrestricted (click to enable 75 % cap)"
fi

printf '{ "text": "%s", "tooltip": "%s", "class": "%s" }\n' \
  "$icon" "$tip" "$class"
