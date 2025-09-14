{ ... }:
{
  imports = [
    ./tailscale.nix
    ./actual.nix
    ./vaultwarden.nix
    ./fail2ban.nix
  ];

  time.timeZone = "UTC";
}
