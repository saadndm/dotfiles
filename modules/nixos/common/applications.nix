{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ghostty
    compose2nix
  ];
}
