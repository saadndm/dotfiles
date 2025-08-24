{ lib, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  systemd.defaultUnit = lib.mkForce "multi-user.target";
}
