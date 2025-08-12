{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    extraDaemonFlags = [
      "--tun=userspace-networking"
      "--socks5-server=0.0.0.0:1055" # SOCKS5 on port 1055
    ];
  };

  networking.firewall = {
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 1055 ];
  };
}
