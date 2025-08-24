{ ... }:
{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "slight";
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
        "Font Awesome 6 Pro"
      ];
      monospace = [
        "JetBrainsMono Nerd Font Mono"
      ];
      sansSerif = [
        "Inter"
        "Noto Sans"
      ];
      serif = [
        "Inter"
        "Noto Serif"
      ];
    };
  };
}
