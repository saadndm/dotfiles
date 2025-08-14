{ config, pkgs, ... }:

{
  imports = [
  ./hyprland.nix
  ];

  time.timeZone = "Asia/Hong_Kong";
}
