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
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      perSystem.xdp-termfilepickers.default
    ];
  };
}
