{ pkgs, ... }:
{
  systemd.services.hypixel-duels-discord-bot = {
    wantedBy = [ "multi-user.target" ];

    environment = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };

    serviceConfig = {
      WorkingDirectory = "/home/bridgesense/Projects/Hypixel-Duels-Discord-Bot";
      ExecStart = "${pkgs.uv}/bin/uv run main.py";
      Restart = "always";
      RestartSec = "10s";
    };
  };
}
