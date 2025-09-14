{ ... }:
{
  imports = [
    ./tailscale.nix
    ./actual.nix
    ./vaultwarden.nix
    ./caddy.nix
    ./immich.nix

    ./ConvertX/docker-compose.nix
  ];

  time.timeZone = "UTC";
}
