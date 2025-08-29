{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
  };
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
