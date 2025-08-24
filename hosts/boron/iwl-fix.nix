{ pkgs, ... }:

let
  iwl-fix-script = pkgs.writeShellScriptBin "iwl-fix.sh" ''
    #!/usr/bin/env bash
    set -euo pipefail

    STATE=/run/iwl-fix.state

    case "$1" in
    pre)
      # Find the current wifi interface
      IF=$(ls /sys/class/net | grep -m1 '^wl') || exit 0
      PCI=$(basename "$(readlink -f /sys/class/net/$IF/device)")
      # Save for post-resume
      printf '%s\n' "$PCI" >"$STATE"

      ip link set "$IF" down || true
      systemctl stop iwd.service || true
      echo 1 >/sys/bus/pci/devices/$PCI/remove
      ;;

    post)
      # Ensure the pre-suspend script ran
      [ -f "$STATE" ] || exit 0
      PCI=$(cat "$STATE")

      # Rescan the PCI bus to make the card reappear
      echo 1 >/sys/bus/pci/rescan

      # Wait for the network interface to reappear
      for i in {1..20}; do
        NETDIR="/sys/bus/pci/devices/$PCI/net"
        [ -d "$NETDIR" ] && IF=$(ls "$NETDIR" | head -1) && break
        sleep 0.25
      done

      # Start iwd again
      systemctl start iwd.service || true
      [ -n "''${IF:-}" ] && ip link set "$IF" up ||
        echo "iwl-fix: iface never reappeared"
      ;;

    *)
      echo "Usage: $0 {pre|post}" >&2
      exit 1
      ;;
    esac
  '';
in
{
  environment.systemPackages = [ iwl-fix-script ];

  systemd.services.wifi-suspend = {
    description = "WiFi: unload card before suspend";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${iwl-fix-script}/bin/iwl-fix.sh pre";
    };
  };

  systemd.services.wifi-resume = {
    description = "WiFi: rescan card after resume";
    after = [ "suspend.target" ];
    wantedBy = [ "suspend.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${iwl-fix-script}/bin/iwl-fix.sh post";
    };
  };
}
