{
  flake,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    flake.nixosModules.common
    # flake.nixosModules.class-server
    inputs.disko.nixosModules.default
    ./hardware-configuration.nix
    ./disk-config.nix
    ./argonone.nix
  ];

  networking.hostName = "helium";

  system.stateVersion = "24.11";
}
