{
  ...
}:
{
  imports = [
    ./dotfiles.nix
    ./yazi.nix
    ./hyprland.nix
    ./applications.nix
    ./fonts.nix
    ./catppuccin.nix
    ./system.nix
    ./ghostty.nix
    ./zen-browser.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
  };
}
