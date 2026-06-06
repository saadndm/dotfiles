{
  pkgs,
  perSystem,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    systemd.setPath.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.Hyprland = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilepickers" ];
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      perSystem.xdp-termfilepickers.default
    ];
  };
}
