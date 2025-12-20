{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets.vaultwarden.path;
    config = {
      DOMAIN = "https://vault.bridgesense.dev";
    };
  };
}
