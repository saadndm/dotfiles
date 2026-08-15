{
  inputs,
  pkgs,
  perSystem,
  ...
}:
{
  xdg.configFile."waybar".source = "${inputs.self}/home/.config/waybar";
  xdg.configFile."walker".source = "${inputs.self}/home/.config/walker";
  xdg.configFile."elephant".source = "${inputs.self}/home/.config/elephant";
  xdg.configFile."mako".source = "${inputs.self}/home/.config/mako";
  xdg.configFile."scripts".source = "${inputs.self}/home/.config/scripts";
  xdg.configFile."ghostty/shaders/cursor_warp.glsl".source =
    "${inputs.self}/home/.config/ghostty/shaders/cursor_warp.glsl";
  xdg.configFile."hypr/hyprlock.conf".source = "${inputs.self}/home/.config/hypr/hyprlock.conf";
  xdg.configFile."hypr/mocha.conf".source = "${inputs.self}/home/.config/hypr/mocha.conf";
  xdg.configFile."hypr/hypridle.conf".source = "${inputs.self}/home/.config/hypr/hypridle.conf";
  xdg.configFile."hypr/config.lua".source = "${inputs.self}/home/.config/hypr/config.lua";
  xdg.configFile."hypr/binds.lua".source = "${inputs.self}/home/.config/hypr/binds.lua";
  xdg.configFile."hypr/startup.lua".source = "${inputs.self}/home/.config/hypr/startup.lua";
  xdg.configFile."hypr/monitors.lua".source = "${inputs.self}/home/.config/hypr/monitors.lua";
  xdg.configFile."hypr/animations.lua".source = "${inputs.self}/home/.config/hypr/animations.lua";
  xdg.configFile."hypr/windowrules.lua".source = "${inputs.self}/home/.config/hypr/windowrules.lua";
  xdg.configFile."kdeglobals".source = "${
    pkgs.catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "blue" ];
    }
  }/share/color-schemes/CatppuccinMochaBlue.colors";
  xdg.configFile."devauth/config.toml".source = "${inputs.self}/home/.config/devauth/config.toml";
  xdg.configFile."looking-glass/client.ini".source =
    "${inputs.self}/home/.config/looking-glass/client.ini";
  xdg.configFile."systemd/user/graphical-session.target.wants/app-com.mitchellh.ghostty.service".source =
    "${perSystem.ghostty.default}/share/systemd/user/app-com.mitchellh.ghostty.service";

  home.file.".wakatime.cfg".source = "${inputs.self}/home/.wakatime.cfg";
  home.file.".clang-format".source = "${inputs.self}/home/.clang-format";
}
