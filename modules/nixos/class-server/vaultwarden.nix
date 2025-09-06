{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets.password.path;
    config = {
      DOMAIN = "https://vault.bridgesense.dev";
      LOG_FILE = "/var/lib/vaultwarden/access.log";
      IP_HEADER = "CF-Connecting-IP";
    };
  };
}
