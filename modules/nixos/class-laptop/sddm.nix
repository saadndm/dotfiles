{ ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    autoLogin = {
      enable = true;
      user = "bridgesense";
    };
  };
}
