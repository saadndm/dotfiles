{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.bash}/bin/bash -lc 'exec start-hyprland >/tmp/start-hyprland.log 2>&1'";
        user = "bridgesense";
      };
      default_session = {
        command = "start-hyprland";
        user = "bridgesense";
      };
    };
  };
}
