{ lib, ... }: {
  virtualisation.waydroid.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = true;
      swtpm.enable = true;
      verbatimConfig = ''
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
          "/dev/rtc","/dev/hpet", "/dev/vfio/vfio",
          "/dev/kvmfr0"
        ]
      '';
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  systemd.services = let
    cleanupLibvirtService = {
      serviceConfig.KillMode = lib.mkForce "mixed";
    };
  in {
    libvirtd = cleanupLibvirtService;
    virtqemud = cleanupLibvirtService;
    virtnetworkd = cleanupLibvirtService;
  };

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  boot = {
    kernelModules = [ "kvmfr" ];

    extraModprobeConfig = ''
      options kvmfr static_size_mb=128
    '';
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", KERNEL=="kvmfr0", OWNER="root", GROUP="libvirtd", MODE="0660"
  '';

  users.users.bridgesense.extraGroups = [ "libvirtd" ];
}
