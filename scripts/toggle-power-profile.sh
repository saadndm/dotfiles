#!/usr/bin/env bash
# Toggle TuneD/PPD profile — the same call Waybar issues

BUS=net.hadess.PowerProfiles
OBJ=/net/hadess/PowerProfiles
IFACE=net.hadess.PowerProfiles

# current PPD profile (power-saver | balanced | performance)
current=$(busctl --system get-property "$BUS" "$OBJ" "$IFACE" \
  ActiveProfile | awk -F'"' '{print $2}')

# ordered list advertised by the daemon
mapfile -t profiles < <(
  busctl --system get-property "$BUS" "$OBJ" "$IFACE" Profiles |
    awk -F'"' '/Profile/ {print $4}'
)

# find "current", choose the next (wrap at end)
next=${profiles[0]}
for i in "${!profiles[@]}"; do
  if [[ ${profiles[i]} == "$current" ]]; then
    next=${profiles[((i + 1) % ${#profiles[@]})]}
    break
  fi
done

# tell the daemon to switch
dbus-send --system --print-reply \
  --dest=$BUS $OBJ \
  org.freedesktop.DBus.Properties.Set \
  string:"$IFACE" \
  string:"ActiveProfile" \
  variant:string:"$next"
