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
  systemd.services.tailscaled-autoconnect.serviceConfig.Type = lib.mkForce "simple";
  networking.firewall = {
    trustedInterfaces = [
      "tailscale0"
    ];
  };
}
