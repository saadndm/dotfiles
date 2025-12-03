{ lib, pkgs, ... }:
{
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/bridgesense/dotfiles";
    };
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
      enable = true;
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
    nodejs
    pnpm

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
    wakatime-cli
    socat
    imagemagick
    ghostscript
    fd
    sqlite
    scooter
    compose2nix
    ffmpeg
    opencode
    zip
  ];
}
