{ ... }:
{
  imports = [
    ./tailscale.nix
    ./vaultwarden.nix
    ./fail2ban.nix
  ];

  time.timeZone = "UTC";
}
