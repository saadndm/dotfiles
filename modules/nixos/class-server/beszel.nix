{ config, ... }:
{
  services.beszel = {
    hub = {
      enable = true;
    };
    agent = {
      enable = true;
      environmentFile = config.age.secrets.beszel-env.path;
    };
  };
}
