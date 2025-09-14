{ ... }:
{
  imports = [
    ./tailscale.nix
    ./actual.nix
    ./vaultwarden.nix
    ./caddy.nix
    ./immich.nix
  ];

  time.timeZone = "UTC";
}
