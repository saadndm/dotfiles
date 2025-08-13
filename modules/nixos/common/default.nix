{ config, ... }:
{
  imports = [
    ./bash.nix
    ./tailscale.nix
    ./agenix.nix
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
      passwordFile = config.age.secrets.password.path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPQrUB4qs/uh+ndRKv46p2qc+D//ctznIH8Hg4lnE8P saad29nadeem@gmail.com-boron-linux"
      ];
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
