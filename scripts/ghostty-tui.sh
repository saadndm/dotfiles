#!/bin/bash

# Create all directories first
mkdir -p ~/.config/ghostty
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/dbus-1/services
mkdir -p ~/.config/systemd/user

# Define the apps and their conceptual sizes (for reference, not used in Ghostty config files)
declare -A apps=(
  ["clipse"]="small"
  ["btop"]="big"
  ["impala"]="small"
  ["bluetui"]="small"
  ["wiremix"]="big"
  ["yazi"]="big"
)

# Create files for each app
for app in "${!apps[@]}"; do
  size="${apps[$app]}" # This variable is kept for your internal reference if needed later
  class="ghostty.$app"

  echo "Creating files for $app (class: $class)..."

  # 1. Ghostty config file (NO window dimensions here)
  cat >~/.config/ghostty/config-$class <<EOF
class = $class
x11-instance-name = $class
command = $app
EOF

  # 2. Desktop file
  cat >~/.local/share/applications/$class.desktop <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=Ghostty ($app)
Comment=Ghostty instance for $app
TryExec=/usr/bin/ghostty
Exec=/usr/bin/ghostty --launched-from=desktop --config-file=/home/$USER/.config/ghostty/config-$class
Icon=com.mitchellh.ghostty
Categories=System;TerminalEmulator;
Keywords=terminal;tty;pty;$app;
StartupNotify=true
StartupWMClass=$class
DBusActivatable=true
Actions=new-window;

[Desktop Action new-window]
Name=New Window
Exec=/usr/bin/ghostty --launched-from=desktop --config-file=/home/$USER/.config/ghostty/config-$class
EOF

  # 3. D-Bus service file
  cat >~/.local/share/dbus-1/services/$class.service <<EOF
[D-BUS Service]
Name=$class
SystemdService=app-$class.service
Exec=/usr/bin/ghostty --launched-from=dbus --config-file=/home/$USER/.config/ghostty/config-$class
EOF

  # 4. systemd user service file
  cat >~/.config/systemd/user/app-$class.service <<EOF
[Unit]
Description=Ghostty ($app) terminal instance
After=graphical-session.target dbus.socket
Requires=dbus.socket

[Service]
Type=notify
BusName=$class
ExecStart=/usr/bin/ghostty --launched-from=systemd --config-file=/home/$USER/.config/ghostty/config-$class
ReloadSignal=SIGUSR2

[Install]
WantedBy=graphical-session.target
EOF

done

# Replace $USER with actual username in all files
actual_user=$(whoami)
find ~/.config/ghostty/config-ghostty.* ~/.local/share/applications/ghostty.*.desktop ~/.local/share/dbus-1/services/ghostty.*.service ~/.config/systemd/user/app-ghostty.*.service -type f -exec sed -i "s|/home/\$USER/|/home/$actual_user/|g" {} \;

echo ""
echo "All files created! Now run:"
echo "systemctl --user daemon-reload"
echo ""
echo "Then enable and start each service:"
for app in "${!apps[@]}"; do
  echo "systemctl --user enable --now app-ghostty.$app.service"
done
echo ""
echo "Test with:"
for app in "${!apps[@]}"; do
  echo "ghostty +new-window --class=ghostty.$app"
done
echo ""
echo "Your new keybinds should be:"
echo "bind = \$mainmod, e, exec, ghostty +new-window --class=ghostty.yazi"
echo "bind = \$mainmod, v, exec, ghostty +new-window --class=ghostty.clipse"
echo "bind = \$mainmod, t, exec, ghostty +new-window --class=ghostty.btop"
echo ""
echo "Your new Waybar configs should be (note: removed -e 'app'):"
echo '    "on-click-right": "ghostty +new-window --class=ghostty.impala"'
echo '    "on-click-right": "ghostty +new-window --class=ghostty.bluetui"'
echo '    "on-click": "ghostty +new-window --class=ghostty.wiremix"'
echo ""
echo "And your Hyprland window rules will need updating (using your current sizes):"
echo "windowrule = float,class:^(ghostty.clipse|ghostty.impala|ghostty.bluetui|ghostty.btop|ghostty.wiremix|ghostty.yazi)"
echo "windowrule = size 622 652, class:^(ghostty.clipse|ghostty.impala|ghostty.bluetui)"
echo "windowrule = size 1200 800,class:^(ghostty.btop|ghostty.wiremix|ghostty.yazi)"
