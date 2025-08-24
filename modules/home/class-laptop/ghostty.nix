{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  apps = {
    clipse = "small";
    btop = "big";
    impala = "small";
    bluetui = "small";
    wiremix = "big";
    yazi = "big";
  };

  ghosttyBin = "${inputs.ghostty.packages.${pkgs.system}.default}/bin/ghostty";
in
{
  xdg.configFile = lib.mapAttrs' (
    name: size:
    let
      class = "ghostty.${name}";
    in
    {
      name = "ghostty/config-${class}";
      value.text = ''
        class = ${class}
        x11-instance-name = ${class}
        command = ${name}
      '';
    }
  ) apps;

  xdg.dataFile = lib.mkMerge [
    (lib.mapAttrs' (
      name: size:
      let
        class = "ghostty.${name}";
      in
      {
        name = "applications/${class}.desktop";
        value.text = ''
          [Desktop Entry]
          Type=Application
          Version=1.0
          Name=Ghostty (${name})
          Comment=Ghostty instance for ${name}
          TryExec=${ghosttyBin}
          Exec=${ghosttyBin} --launched-from=desktop --config-file=${config.home.homeDirectory}/.config/ghostty/config-${class}
          Icon=com.mitchellh.ghostty
          Categories=System;TerminalEmulator;
          Keywords=terminal;tty;pty;${name};
          StartupNotify=true
          StartupWMClass=${class}
          Terminal=false
          Actions=new-window;
          X-GNOME-UsesNotifications=true
          DBusActivatable=true

          [Desktop Action new-window]
          Name=New Window
          Exec=${ghosttyBin} --launched-from=desktop --config-file=${config.home.homeDirectory}/.config/ghostty/config-${class}
        '';
      }
    ) apps)

    (lib.mapAttrs' (
      name: size:
      let
        class = "ghostty.${name}";
      in
      {
        name = "dbus-1/services/${class}.service";
        value.text = ''
          [D-BUS Service]
          Name=${class}
          SystemdService=app-${class}.service
          Exec=${ghosttyBin} --launched-from=dbus --config-file=${config.home.homeDirectory}/.config/ghostty/config-${class}
        '';
      }
    ) apps)
  ];

  systemd.user.services = lib.mapAttrs' (
    name: size:
    let
      class = "ghostty.${name}";
      cfgFile = "${config.home.homeDirectory}/.config/ghostty/config-${class}";
    in
    {
      name = "app-${class}";
      value = {
        Unit = {
          Description = "Ghostty (${name}) terminal instance";
          After = [
            "graphical-session.target"
            "dbus.socket"
          ];
          Requires = [ "dbus.socket" ];
        };
        Service = {
          Type = "notify-reload";
          BusName = class;
          ExecStart = "${ghosttyBin} --launched-from=systemd --config-file=${cfgFile}";
          ReloadSignal = "SIGUSR2";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    }
  ) apps;
}
