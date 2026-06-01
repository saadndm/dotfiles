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
  xdg.configFile."ghostty".source = "${inputs.self}/home/.config/ghostty";
  xdg.configFile."oama/config.yaml".source = "${inputs.self}/home/.config/oama/config.yaml";
  xdg.configFile."clipse/config.json".source = "${inputs.self}/home/.config/clipse/config.json";
  xdg.configFile."clipse/custom_theme.json".source =
    "${inputs.self}/home/.config/clipse/custom_theme.json";
  xdg.configFile."hypr/hyprlock.conf".source = "${inputs.self}/home/.config/hypr/hyprlock.conf";
  xdg.configFile."hypr/mocha.conf".source = "${inputs.self}/home/.config/hypr/mocha.conf";
  xdg.configFile."hypr/hypridle.conf".source = "${inputs.self}/home/.config/hypr/hypridle.conf";
  xdg.configFile."devauth/config.toml".source = "${inputs.self}/home/.config/devauth/config.toml";
  home.file.".wakatime.cfg".source = "${inputs.self}/home/.wakatime.cfg";
  xdg.configFile."looking-glass/client.ini".source =
    "${inputs.self}/home/.config/looking-glass/client.ini";
  xdg.configFile."systemd/user/graphical-session.target.wants/app-com.mitchellh.ghostty.service".source =
    "${perSystem.ghostty.default}/share/systemd/user/app-com.mitchellh.ghostty.service";
}
