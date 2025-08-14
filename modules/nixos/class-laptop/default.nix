{ config, pkgs, ... }:

{
  imports = [
  ./hyprland.nix
  ];

  services.getty.autologinUser = "bridgesense";

  time.timeZone = "Asia/Hong_Kong";
}
