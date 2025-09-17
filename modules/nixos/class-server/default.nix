{ ... }:
{
  imports = [
    ./tailscale.nix
    ./actual.nix
    ./vaultwarden.nix
    ./caddy.nix
    ./immich.nix

    ./ConvertX/docker-compose.nix
    ./Dawarich/docker-compose.nix
  ];

  time.timeZone = "UTC";
}
