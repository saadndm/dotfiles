{ ... }:

{
  imports = [
    ./hyprland.nix
    ./networking.nix
    ./audio.nix
    ./system.nix
    ./fonts.nix
    ./stylix.nix
    ./seamless-login.nix
    ./gnome.nix
    ./cron.nix
    ./packages.nix
  ];

  time.timeZone = "America/Toronto";
}
