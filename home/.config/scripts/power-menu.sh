#!/usr/bin/env bash

show_power_menu() {
  # The first characters are invisible sort keys.
  local menu_options="\u2063<span font='Font Awesome 6 Pro Solid'>&#xf011;</span> Shutdown
\u200C<span font='Font Awesome 6 Pro Solid'>&#xf880;</span> Suspend
\u200B<span font='Font Awesome 6 Pro Solid'>&#xf023;</span> Lock
\u2060<span font='Font Awesome 6 Pro Solid'>&#xf021;</span> Restart
\u200D<span font='Font Awesome 6 Pro Solid'>&#xf2d2;</span> Relaunch
"
  local selection=$(echo -e "$menu_options" | walker --dmenu -p " Actions")

  case "$selection" in
  *Lock*) hyprlock ;;
  *Suspend*) systemctl suspend ;;
  *Relaunch*) uwsm stop ;;
  *Restart*) systemctl reboot ;;
  *Shutdown*) systemctl poweroff ;;
  esac
}

show_power_menu
