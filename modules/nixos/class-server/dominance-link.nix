{ pkgs, ... }:
{
  systemd.services.dominance-link = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      WorkingDirectory = "/home/bridgesense/Projects/Dominance-Link/src";
      ExecStart = "${pkgs.bun}/bin/bun /home/bridgesense/Projects/Dominance-Link/src/index.ts";
      Restart = "always";
      RestartSec = "10s";
    };
  };
}
