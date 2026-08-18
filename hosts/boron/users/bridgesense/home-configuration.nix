{
  flake,
  ...
}:
{
  imports = [
    flake.homeModules.common
    flake.homeModules.class-laptop
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("~/.config/scripts/hyproled.sh -a 0:0:2880:67 -s -m 0")
      hl.exec_cmd("~/.config/scripts/hyproled.sh listen")
    end)
  '';
}
