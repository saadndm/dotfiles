{ lib, pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };

    fzf = {
      enable = true;
      colors.bg = lib.mkForce "#181825";
      enableFishIntegration = false;
    };

    bat = {
      config = {
        theme = "Catppuccin Mocha";
      };
    };

    lazydocker = {
      enable = true;
    };

    java = {
      enable = true;
      package = pkgs.temurin-bin-21;
    };
  };

  home.file.".jdks/temurin-bin-21".source = pkgs.temurin-bin-21;
  home.file.".jdks/temurin-bin-17".source = pkgs.temurin-bin-17;
  home.file.".jdks/temurin-bin-8".source = pkgs.temurin-bin-8;

  home.packages = with pkgs; [
    gcc
    typescript
    go
    bun

    jq
    uv
    dig
    curl
    wget
    lazygit
    eza
    zoxide
    unzip
    ripgrep
    fastfetch
    compose2nix
    wakatime
    socat
  ];
}
