#!/usr/bin/env bash

show_power_menu() {
  # The first characters are invisible sort keys.
  local menu_options="\u2063 Shutdown
\u200B Lock
\u2060 Restart
\u200C Suspend
\u200D Relaunch
"
  local selection=$(echo -e "$menu_options" | walker --dmenu -p " Actions")

  case "$selection" in
  *Lock*) hyprlock ;;
  *Suspend*) systemctl suspend ;;
  *Relaunch*) uwsm stop ;;
  *Restart*) systemctl reboot ;;
  *Shutdown*) systemctl poweroff ;;
  esac
}

show_power_menu
