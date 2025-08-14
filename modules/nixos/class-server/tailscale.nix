{ lib, ... }:
{
  services = {
    tailscale = {
      useRoutingFeatures = lib.mkForce "server";
      extraUpFlags = [
        "--advertise-exit-node"
      ];
    };
  };
}
