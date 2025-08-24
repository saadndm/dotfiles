{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaBlue;
    name = "catppuccin-mocha-blue-cursos";
    size = 16;
  };
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
