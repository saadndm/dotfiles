{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = false;
    cache.enable = true;
    flavor = "mocha";
    accent = "blue";
    btop.enable = true;
    fzf.enable = true;
    bat.enable = true;
    yazi.enable = true;
    lazygit.enable = true;
    eza.enable = true;
    obs.enable = true;
    mpv.enable = true;
    sioyek.enable = true;
    ghostty.enable = true;
    kitty.enable = true;
    delta.enable = true;
    thunderbird = {
      enable = true;
      profile = "default";
    };
  };
}
