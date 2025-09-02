{
  flake,
  inputs,
  ...
}:

{
  imports = [
    flake.nixosModules.common
    flake.nixosModules.class-server
    inputs.disko.nixosModules.default
    ./hardware-configuration.nix
    ./disk-config.nix
    ./cloudflared.nix
  ];

  networking.hostName = "carbon";

  system.stateVersion = "24.11";
}
