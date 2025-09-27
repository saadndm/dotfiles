{ config, ... }:
{
  services.wakapi = {
    enable = true;
    passwordSaltFile = config.age.secrets.wakapi-salt.path;
    settings = {
      server = {
        port = 8080;
        public_url = "https://wakapi.bridgesense.dev";
      };
    };
  };
}
