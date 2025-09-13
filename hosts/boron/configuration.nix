{
  flake,
  inputs,
  ...
}:

{
  imports = [
    flake.nixosModules.common
    flake.nixosModules.class-laptop
    inputs.disko.nixosModules.default
    inputs.i915-sriov.nixosModules.default
    ./hardware-configuration.nix
    ./disk-config.nix
    ./iwl-fix.nix
    ./plymouth.nix
  ];

  networking.hostName = "boron";

  system.stateVersion = "25.05";
}
