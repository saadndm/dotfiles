{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.determinate.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./bash.nix
    ./tailscale.nix
    ./agenix.nix
    ./stylix.nix
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
    trusted-users = [
      "root"
      "@wheel"
      "bridgesense"
    ];
  };

  programs.nix-ld.enable = true;

  networking = {
    nftables.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  security.sudo.extraConfig = "Defaults passwd_tries=10";

  environment = {
    enableAllTerminfo = true;
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    etc."security/faillock.conf".text = ''
      deny = 10
    '';
  };

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
