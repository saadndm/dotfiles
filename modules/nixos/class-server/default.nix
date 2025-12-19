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

    ./dominance-link.nix
    ./hypixel-duels-discord-bot.nix

    ./Dawarich/docker-compose.nix
    ./Beszel/docker-compose.nix
    ./VERT/docker-compose.nix
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
