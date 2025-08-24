{ ... }:

{
  imports = [
    ./hyprland.nix
    ./networking.nix
    ./audio.nix
    ./system.nix
    ./fonts.nix
    ./stylix.nix
  ];

  services.getty.autologinUser = "bridgesense";

  time.timeZone = "America/Toronto";
}
