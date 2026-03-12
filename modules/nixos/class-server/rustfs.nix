{
  inputs,
  perSystem,
  config,
  ...
}:
{
  imports = [
    inputs.rustfs.nixosModules.rustfs
  ];

  services = {
    rustfs = {
      enable = true;
      package = perSystem.rustfs.default;
      accessKeyFile = config.age.secrets.kopia.path;
      secretKeyFile = config.age.secrets.kopia.path;
      volumes = "/var/lib/rustfs";
      address = ":9000";
      consoleEnable = true;
    };
  };
}
