{
  flake,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    flake.nixosModules.common
    flake.nixosModules.class-laptop
    inputs.disko.nixosModules.default
    inputs.i915-sriov.nixosModules.default
    ./hardware-configuration.nix
    ./disk-config.nix
    ./plymouth.nix
  ];

  networking.hostName = "boron";

  system.stateVersion = "25.05";

  security = {
    sudo.extraRules = [
      {
        users = [ "bridgesense" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/tee /sys/class/leds/platform\\:\\:mute/brightness";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\\:00/conservation_mode";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
    wrappers = {
      intel_gpu_top = {
        owner = "root";
        group = "root";
        source = "${pkgs.intel-gpu-tools}/bin/intel_gpu_top";
        capabilities = "cap_perfmon+ep";
      };
      btop = {
        owner = "root";
        group = "root";
        source = "${pkgs.btop}/bin/btop";
        capabilities = "cap_perfmon+ep";
      };
    };
  };

  systemd.services.sriov-setup = {
    description = "Configure SR-IOV";
    wantedBy = [ "multi-user.target" ];
    unitConfig = {
      After = [
        "systemd-udev-settle.service"
        "local-fs.target"
        "systemd-modules-load.service"
      ];
      Before = [ "libvirtd.service" ];
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'for i in $(seq 1 5); do echo 1 > /sys/devices/pci0000:00/0000:00:02.0/sriov_numvfs && break; sleep 1; done'";
      User = "root";
    };
  };
}
