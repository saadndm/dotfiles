{ config, ... }:

{
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale.path;
    openFirewall = true;
    useRoutingFeatures = "client";
    extraUpFlags = [
      "--ssh"
    ];
    extraDaemonFlags = [
      "--tun=userspace-networking"
      "--socks5-server=0.0.0.0:1055"
    ];
  };
  networking.firewall = {
    trustedInterfaces = [
      "tailscale0"
    ];
  };
}
