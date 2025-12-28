{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./bash.nix
    ./tailscale.nix
    ./agenix.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org/"
    ];
    extra-substituters = [ "https://yazi.cachix.org" ];
    extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
    trusted-users = [
      "root"
      "@wheel"
      "bridgesense"
    ];
  };

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      timeout = 1;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/Toronto";

  users = {
    mutableUsers = false;
    users.bridgesense = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      linger = true;
      # Initial password: temp
      # initialHashedPassword = "$6$randomsalt$vj1dHwOh9AOg8xgdq529s1YrNYduioIlHHlrc/lfQRUp3lA0PG7ajlSL6JgnM87MtZ2ExRgWEOuNB9A3c/9Uw.";
      hashedPasswordFile = config.age.secrets.login.path;
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

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-gtk3-1.1.07"
  ];
}
