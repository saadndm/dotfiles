{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "blue";
    fish.enable = true;
    fzf.enable = true;
    bat.enable = true;
    aerc.enable = true;
    yazi.enable = true;
  };
}
