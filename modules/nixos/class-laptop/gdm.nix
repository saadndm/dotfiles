{ ... }:

{
  programs.uwsm.enable = true;

  systemd.services."getty@tty1".enable = false;

  services.displayManager.gdm = {
    enable = true;
  };

  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    autoLogin.enable = true;
    autoLogin.user = "bridgesense";
  };
}
