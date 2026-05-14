{
  lib,
  pkgs,
  perSystem,
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
    lazygit = {
      enable = true;
      settings = {
        git.log.order = "default";
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
      tui = {
        theme = "catppuccin";
      };
    };
  };

  home.file.".jdks/temurin-bin-21".source = pkgs.temurin-bin-21;
  home.file.".jdks/temurin-bin-17".source = pkgs.temurin-bin-17;
  home.file.".jdks/temurin-bin-8".source = pkgs.temurin-bin-8;

  home.packages = with pkgs; [
    perSystem.agenix.default
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
    kopia
    gnumake
    man-pages
    hydra-check
    cloc
  ];
}
