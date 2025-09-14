{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets.password.path;
    config = {
      DOMAIN = "https://vault.bridgesense.dev";
    };
  };
}
