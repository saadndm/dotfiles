{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    typescript
    temurin-bin-8
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
