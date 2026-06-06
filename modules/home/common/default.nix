{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvim.homeModules.default
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./catppuccin.nix
    ./yazi.nix
    ./stylix.nix
  ];

  wrappers.nvim.enable = true;

  home = {
    username = "bridgesense";
    homeDirectory = "/home/bridgesense";
    stateVersion = "26.05";
  };
}
