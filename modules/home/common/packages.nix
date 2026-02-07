{
  lib,
  pkgs,
  inputs,
  ...
}:
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
      defaultOptions = [
        "--preview ${lib.escapeShellArg "bat --color=always --style=numbers --line-range=:500 {}"}"
      ];
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

    eza = {
      enable = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
      ];
    };

    opencode = {
      enable = true;
      settings = {
        theme = "catppuccin";
      };
    };
  };

  home.file.".jdks/temurin-bin-21".source = pkgs.temurin-bin-21;
  home.file.".jdks/temurin-bin-17".source = pkgs.temurin-bin-17;
  home.file.".jdks/temurin-bin-8".source = pkgs.temurin-bin-8;

  home.packages = with pkgs; [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    typescript
    go
    bun
    nodejs
    pnpm
    clang
    clang-tools
    ghc

    jq
    uv
    dig
    curl
    wget
    lazygit
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
    zip
    gh
    delta
    bat-extras.core
  ];
}
