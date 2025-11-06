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

  systemd.services.tailscaled-autoconnect = {
    after = lib.mkForce [
      "network-online.target"
      "tailscaled.service"
    ];
    wantedBy = lib.mkForce [ "network-online.target" ];
    wants = lib.mkForce [
      "network-online.target"
      "tailscaled.service"
    ];
  };
}
