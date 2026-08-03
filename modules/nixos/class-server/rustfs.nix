{ config, ... }:
{
  services.rustfs = {
    enable = true;
    environmentFile = config.age.secrets.rustfs-env.path;
    settings = {
      RUSTFS_CONSOLE_ENABLE = "true";
      RUSTFS_CONSOLE_ADDRESS = ":9000";
      RUSTFS_VOLUMES = "/var/lib/rustfs";
    };
  };
}
