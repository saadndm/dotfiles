{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "blue";
    fish.enable = true;
    btop.enable = true;
    fzf.enable = true;
    bat.enable = true;
    yazi.enable = true;
    lazygit.enable = true;
    eza.enable = true;
    obs.enable = true;
    mpv.enable = true;
    sioyek.enable = true;
  };
}
