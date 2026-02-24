{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
    };
    email = "saadndm.sn@gmail.com";
    environmentFile = config.age.secrets.cloudflare.path;
    extraConfig = ''
      (ts_host) {
        bind 100.105.172.124

        @blocked not remote_ip 100.64.0.0/10

        tls {
          resolvers 1.1.1.1
            dns cloudflare {
              api_token {env.CLOUDFLARE_API_TOKEN}
            }
          }

        respond @blocked "Unauthorized" 403
      }
    '';
    virtualHosts = {
      "actual.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:5006
        '';
      };
      "vault.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:8000
        '';
      };
      "immich.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:2283
        '';
      };
      "vert.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:3000
        '';
      };
      "dawarich.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:4000
        '';
      };
      "beszel.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:8090
        '';
      };
      "wakapi.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:8080
        '';
      };
      "it-tools.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:9100
        '';
      };
      "papra.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:1221
        '';
      };
      "rustfs-carbon.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:9000
        '';
      };
      "kopia-carbon.saadndm.com" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:51515
        '';
      };
    };
  };

  systemd.services.caddy = {
    after = [
      "network-online.target"
      "tailscaled.service"
    ];
    wants = [
      "network-online.target"
      "tailscaled.service"
    ];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
      RestartPreventExitStatus = lib.mkForce "";
    };
  };
}
