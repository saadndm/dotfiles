{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "168fc309-1d5e-4158-91c1-a54e0e975900" = {
        credentialsFile = "${config.age.secrets.cloudflared-carbon.path}";
        ingress = {
        };
        default = "http_status:404";
      };
    };
  };
}
