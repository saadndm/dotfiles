{ inputs, pkgs, ... }:
{
  imports = [
    inputs.rustfs.nixosModules.rustfs
  ];

  services = {
    rustfs = {
      enable = true;
      package = inputs.rustfs.packages.${pkgs.stdenv.hostPlatform.system}.default;
      accessKey = "rustfsadmin";
      secretKey = "rustfsadmin";
      volumes = "/var/lib/rustfs";
      address = ":9000";
      consoleEnable = true;
    };
  };
}
