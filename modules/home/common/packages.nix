{ pkgs, ... }:
{
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
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
  ];
}
