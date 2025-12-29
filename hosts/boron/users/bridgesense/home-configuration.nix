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
      exec-once = ~/.config/scripts/hyproled.sh -a 0:0:2880:67 -s -m 0
      exec-once = ~/.config/scripts/hyproled.sh listen
    '';
  };
}
