{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvim.homeModules.default
    ./development.nix
    ./fish.nix
    ./nvim.nix
    ./git.nix
  ];

  home = {
    username = "bridgesense";
    homeDirectory = "/home/bridgesense";
    stateVersion = "25.05";
  };
}
