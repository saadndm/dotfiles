{ inputs, ... }:
{
  xdg.configFile."waybar".source = "${inputs.self}/home/.config/waybar";
  xdg.configFile."walker/config.toml".source = "${inputs.self}/home/.config/walker/config.toml";
  xdg.configFile."walker/themes/catppuccin.toml".source =
    "${inputs.self}/home/.config/walker/themes/catppuccin.toml";
  xdg.configFile."walker/themes/catppuccin.css".source =
    "${inputs.self}/home/.config/walker/themes/catppuccin.css";
  xdg.configFile."mako".source = "${inputs.self}/home/.config/mako";
  xdg.configFile."scripts".source = "${inputs.self}/home/.config/scripts";
  xdg.configFile."ghostty/config".source = "${inputs.self}/home/.config/ghostty/config";
  xdg.configFile."oama/config.yaml".source = "${inputs.self}/home/.config/oama/config.yaml";
  xdg.configFile."uwsm/env".source = "${inputs.self}/home/.config/uwsm/env";
  xdg.configFile."uwsm/env-hyprland".source = "${inputs.self}/home/.config/uwsm/env-hyprland";
  xdg.configFile."clipse/config.json".source = "${inputs.self}/home/.config/clipse/config.json";
  xdg.configFile."clipse/custom_theme.json".source =
    "${inputs.self}/home/.config/clipse/custom_theme.json";
  xdg.configFile."hypr/hyprlock.conf".source = "${inputs.self}/home/.config/hypr/hyprlock.conf";
  xdg.configFile."hypr/mocha.conf".source = "${inputs.self}/home/.config/hypr/mocha.conf";
  xdg.configFile."hypr/hypridle.conf".source = "${inputs.self}/home/.config/hypr/hypridle.conf";
  xdg.configFile."aerc/binds.conf".source = "${inputs.self}/home/.config/aerc/binds.conf";
  xdg.configFile."aerc/accounts.conf".source = "${inputs.self}/home/.config/aerc/accounts.conf";
  xdg.configFile."racket/racket-prefs.rktd".source =
    "${inputs.self}/home/.config/racket/racket-prefs.rktd";
}
