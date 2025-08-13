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

  # Enable passwordless sudo.
  security.sudo.extraRules = [
    {
      users = [ "bridgesense" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  system.stateVersion = "24.11";
}
