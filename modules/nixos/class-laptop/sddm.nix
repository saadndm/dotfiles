{ ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoLogin = {
      enable = true;
      user = "bridgesense";
    };
  };

  services.displayManager = {
    defaultSession = "hyprland-uwsm";
  };
}
