{
  inputs,
  lib,
  perSystem,
  pkgs,
  ...
}:
{
  imports = [ inputs.xdp-termfilepickers.homeManagerModules.default ];
  services.xdg-desktop-portal-termfilepickers =
    let
      termfilepickers = perSystem.xdp-termfilepickers.default;
    in
    {
      enable = true;
      package = termfilepickers;
      config = {
        terminal_command = [
          (lib.getExe pkgs.kitty)
          "--class=Yazi"
        ];
      };
    };
}
