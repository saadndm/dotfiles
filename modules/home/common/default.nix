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

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "bridgesense";
    homeDirectory = "/home/bridgesense";
    stateVersion = "25.05";
  };
}
