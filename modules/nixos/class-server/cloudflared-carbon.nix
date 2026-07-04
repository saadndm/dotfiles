{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "e1d2d1bb-4dcb-4fe4-94f2-e4e436f6cc8c" = {
        credentialsFile = config.age.secrets.cloudflared-carbon.path;
        ingress = {
          "repo.saadndm.com" = "http://localhost:8085";
        };
        default = "http_status:404";
      };
    };
  };
}
