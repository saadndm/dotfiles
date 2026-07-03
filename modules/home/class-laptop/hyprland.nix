{
  perSystem,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = perSystem.hyprland.hyprland;
    configType = "lua";
    systemd.variables = [ "--all" ];
    extraConfig = ''
      require("config")
    '';
  };
}
