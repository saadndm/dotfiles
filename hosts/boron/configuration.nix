{
  flake,
  inputs,
  ...
}:

{
  imports = [
    flake.nixosModules.common
    inputs.disko.nixosModules.default
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  networking.hostName = "boron";

  system.stateVersion = "25.05";
}
