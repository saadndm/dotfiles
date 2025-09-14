{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-j+xUy8OAjEo+bdMOkQ1kVqDnEkzKGTBIbMDVL7YDwDY=";
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
    };
  };
}
