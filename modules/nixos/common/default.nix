{ pkgs, config, ... }:
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
    kernelPackages = pkgs.linuxPackages_latest;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    mutableUsers = false;
    users.bridgesense = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      # Initial password: temp
      # initialHashedPassword = "$6$randomsalt$vj1dHwOh9AOg8xgdq529s1YrNYduioIlHHlrc/lfQRUp3lA0PG7ajlSL6JgnM87MtZ2ExRgWEOuNB9A3c/9Uw.";
      hashedPasswordFile = config.age.secrets.password.path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPQrUB4qs/uh+ndRKv46p2qc+D//ctznIH8Hg4lnE8P saad29nadeem@gmail.com-boron-linux"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDaj9tr/+tlavpoeFeLN2Xbr50wvR4fVNKd59ZxlQIBD bridgesense@fedora"
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = false;
  };
}
