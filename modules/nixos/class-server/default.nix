{ config, pkgs, ... }:
{
  imports = [ ./tailscale.nix ];

  time.timeZone = "UTC";
}
