{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvim.homeModules.default
    ./development.nix
    ./agenix.nix
    ./fish.nix
    ./nvim.nix
    ./git.nix
  ];

  home = {
    username = "bridgesense";
    homeDirectory = "/home/bridgesense";
    stateVersion = "25.05";
    packages = with pkgs; [
      home-manager
    ];
  };
}
