{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    go.enable = true;
    bat.enable = true;
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
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    inputs.agenix.packages.${pkgs.system}.default
    gcc
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
    zoxide
    unzip
    ripgrep
    fastfetch
  ];
}
