{ pkgs, lib, ... }:
{
  programs = {
    go.enable = true;
    bat.enable = true;
    btop.enable = true;
    fzf = {
      enable = true;
      colors.bg = lib.mkForce "#181825";
    };
  };

  home.packages = with pkgs; [
    gotools
    gopls
    golangci-lint
    typescript
    jq
    bun
    nodejs
    uv
    dig
    curl
    wget
    lazygit
    eza
    home-manager
    zoxide
    unzip
    ripgrep
  ];
}
