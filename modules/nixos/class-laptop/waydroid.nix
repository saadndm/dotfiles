{ ... }:
{
  virtualisation.waydroid.enable = true;

  # boot.kernelModules = [
  #   "binder_linux"
  #   "ashmem_linux"
  # ];
  #
  # # Enable IPv4 forwarding
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  # };

  networking = {
    nftables = {
      enable = true;
      ruleset = ''
        table inet filter {
          chain input {
            type filter hook input priority filter; policy accept;
            iifname "waydroid0" accept comment "Allow incoming from Waydroid"
          }

          chain forward {
            type filter hook forward priority filter; policy accept;
            iifname "waydroid0" accept comment "Allow outgoing from Waydroid"
            ct state { established, related } counter accept comment "Accept established connections"
          }
        }

        table ip nat {
          chain postrouting {
            type nat hook postrouting priority srcnat; policy accept;
            ip saddr 192.168.250.0/24 ip daddr != 192.168.250.0/24 masquerade
          }
        }
      '';
    };
  };
}
