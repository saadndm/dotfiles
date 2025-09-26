{ ... }:

{
  imports = [
    ./hyprland.nix
    ./networking.nix
    ./audio.nix
    ./steam.nix
    ./system.nix
    ./fonts.nix
    ./stylix.nix
    ./gdm.nix
    ./gnome.nix
    ./cron.nix
  ];

  time.timeZone = "America/Toronto";
}
