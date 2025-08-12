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

  users.users.bridgesense.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPQrUB4qs/uh+ndRKv46p2qc+D//ctznIH8Hg4lnE8P saad29nadeem@gmail.com-carbon-nixos"
  ];

  system.stateVersion = "24.11";
}
