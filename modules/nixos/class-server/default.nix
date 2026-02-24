{ ... }:
{
  imports = [
    ./tailscale.nix
    ./actual.nix
    ./vaultwarden.nix
    ./caddy.nix
    ./immich.nix
    ./wakapi.nix
    ./podman.nix
    ./dawarich.nix
    ./beszel.nix
    ./rustfs.nix

    ./dominance-link.nix
    ./hypixel-duels-discord-bot.nix

    ./VERT/docker-compose.nix
    ./IT-Tools/docker-compose.nix
    ./Papra/docker-compose.nix
  ];

  security.sudo.extraRules = [
    {
      users = [ "bridgesense" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/rsync";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
