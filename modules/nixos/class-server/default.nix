{ ... }:
{
  imports = [
    ./tailscale.nix
    ./actual.nix
    ./vaultwarden.nix
    ./caddy.nix
    ./immich.nix
    ./wakapi.nix

    ./ConvertX/docker-compose.nix
    ./Dawarich/docker-compose.nix
    ./Beszel/docker-compose.nix
  ];
}
