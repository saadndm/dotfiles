{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "b45b90a4-8ed7-411b-9922-04f2405bcfac" = {
        credentialsFile = "${config.age.secrets.cloudflared-carbon.path}";
        default = "http_status:404";
      };
    };
  };
}
