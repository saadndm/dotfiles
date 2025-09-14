{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    temurin-bin-8
    temurin-bin-21
  ];
}
