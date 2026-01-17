{ ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager = {
    defaultSession = "hyprland";
    autoLogin = {
      enable = true;
      user = "bridgesense";
    };
  };
}
