{ inputs, pkgs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "blue";
    fish.enable = true;
  };
}
