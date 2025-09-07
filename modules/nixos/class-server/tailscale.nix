{ lib, ... }:
{
  services = {
    tailscale = {
      useRoutingFeatures = lib.mkForce "server";
      extraDaemonFlags = [
        "--tun=userspace-networking"
        "--socks5-server=0.0.0.0:1055"
      ];
      extraUpFlags = [
        "--advertise-exit-node"
      ];
    };
  };
}
