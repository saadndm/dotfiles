{
  flake,
  ...
}:
{
  imports = [
    flake.homeModules.common
    flake.homeModules.class-laptop
  ];

  wayland.windowManager.hyprland = {
    extraConfig = ''
      exec-once = ~/.config/scripts/wp-mute-listener.sh
    '';
  };
}
