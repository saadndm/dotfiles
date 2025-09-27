{ config, lib, ... }:

{
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale.path;
    openFirewall = true;
    useRoutingFeatures = "client";
    extraUpFlags = [
      "--ssh"
    ];
  };

  networking.firewall = {
    trustedInterfaces = [
      "tailscale0"
    ];
  };
}
