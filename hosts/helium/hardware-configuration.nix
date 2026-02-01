{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_rpi5;
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = lib.mkForce false;
    };
  };

  hardware.raspberry-pi.config.all = {
    base-dt-params = {
      uart0 = {
        enable = true;
        value = "on";
      };
      pciex1 = {
        enable = true;
        value = "on";
      };
      pciex1_gen = {
        enable = true;
        value = "3";
      };
      nvme = {
        enable = true;
        value = "on";
      };
      i2c_arm = {
        enable = true;
        value = "on";
      };
    };

    options = {
      usb_max_current_enable = {
        enable = true;
        value = "1";
      };
    };

    dt-overlays.vc4-kms-v3d.enable = false;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
