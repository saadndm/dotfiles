{ inputs, ... }:
{
  class = "nixos";

  value = inputs.nixos-raspberrypi.lib.nixosSystem {
    system = "aarch64-linux";

    specialArgs = {
      inherit inputs;
      flake = inputs.self;
      nixos-raspberrypi = inputs.nixos-raspberrypi;
    };

    modules = [
      ./configuration.nix
    ];
  };
}
