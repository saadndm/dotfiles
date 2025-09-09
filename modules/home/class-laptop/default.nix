{
  ...
}:
{
  imports = [
    ./dotfiles.nix
    ./yazi.nix
    ./termfilepickers.nix
    ./hyprland.nix
    ./applications.nix
    ./fonts.nix
    ./catppuccin.nix
    ./stylix.nix
    ./system.nix
    ./zen-browser.nix
    ./kanshi.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
  };
}
