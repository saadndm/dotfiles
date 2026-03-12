{ config, ... }:
{
  services.beszel = {
    hub = {
      enable = true;
    };
    agent = {
      enable = true;
      openFirewall = true;
      environmentFile = config.age.secrets.beszel-env.path;
    };
  };

  users.groups.beszel-agent = { };
  users.users.beszel-agent = {
    isSystemUser = true;
    group = "beszel-agent";
  };
}
