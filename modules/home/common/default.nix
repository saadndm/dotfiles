{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvim.homeModules.default
    ./agenix.nix
    ./shell.nix
    ./git.nix
    ./catppuccin.nix
  ];

  nvim.enable = true;

  home = {
    username = "bridgesense";
    homeDirectory = "/home/bridgesense";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      home-manager
    ];
  };
}
