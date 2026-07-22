_: {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.variables = [ "--all" ];
    extraConfig = ''
      require("config")
    '';
  };
}
