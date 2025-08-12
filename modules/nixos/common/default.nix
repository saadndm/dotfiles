{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./tailscale.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd.systemd.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    mutableUsers = false;
    users.bridgesense = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
