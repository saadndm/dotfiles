{
  perSystem,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    package = perSystem.hyprland.hyprland;
    portalPackage = perSystem.hyprland.xdg-desktop-portal-hyprland;
    systemd.setPath.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.Hyprland = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilepickers" ];
    };
    extraPortals = [
      perSystem.hyprland.xdg-desktop-portal-hyprland
      perSystem.xdp-termfilepickers.default
    ];
  };
}
