{ pkgs, ... }:
{
  home.packages = with pkgs; [
    upower
    intel-gpu-tools
    brightnessctl
    wireplumber
  ];
}
