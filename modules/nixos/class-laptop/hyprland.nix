{ pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    systemd.setPath.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      inputs.xdp-termfilepickers.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
