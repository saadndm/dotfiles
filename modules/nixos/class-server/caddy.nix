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
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-Dvifm7rRwFfgXfcYvXcPDNlMaoxKd5h4mHEK6kJ+T4A=";
    };
    email = "bridgesensemc@gmail.com";
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
      "actual.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:5006
        '';
      };
      "vault.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:8000
        '';
      };
      "immich.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:2283
        '';
      };
      "vert.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:3000
        '';
      };
      "dawarich.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:4000
        '';
      };
      "beszel.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:8090
        '';
      };
      "wakapi.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:8080
        '';
      };
      "it-tools.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:9000
        '';
      };
      "papra.bridgesense.dev" = {
        extraConfig = ''
          import ts_host
          reverse_proxy localhost:1221
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
