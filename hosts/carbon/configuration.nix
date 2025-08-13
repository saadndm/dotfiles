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

  networking.hostName = "carbon";

  system.stateVersion = "24.11";
}
