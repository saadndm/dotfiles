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
    };

    lazydocker = {
      enable = true;
    };

    java = {
      enable = true;
      package = pkgs.temurin-bin-21;
    };
  };

  home.packages = with pkgs; [
    gcc
    typescript
    temurin-bin-21
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
    bat
  ];
}
