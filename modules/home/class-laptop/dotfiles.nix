{ inputs, ... }:
{
  xdg.configFile."hypr".source = "${inputs.self}/home/.config/hypr";
  xdg.configFile."waybar".source = "${inputs.self}/home/.config/waybar";
  xdg.configFile."walker/config.toml".source = "${inputs.self}/home/.config/walker/config.toml";
  xdg.configFile."walker/themes/catppuccin.toml".source =
    "${inputs.self}/home/.config/walker/themes/catppuccin.toml";
  xdg.configFile."walker/themes/catppuccin.css".source =
    "${inputs.self}/home/.config/walker/themes/catppuccin.css";
  xdg.configFile."mako".source = "${inputs.self}/home/.config/mako";
  xdg.configFile."scripts".source = "${inputs.self}/home/.config/scripts";
  xdg.configFile."ghostty/config".source = "${inputs.self}/home/.config/ghostty/config";
  xdg.configFile."racket/racket-prefs.rktd".source =
    "${inputs.self}/home/.config/racket/racket-prefs.rktd";
}
