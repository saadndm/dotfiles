{ pkgs, ... }:
let
  font-awesome-6-pro = pkgs.stdenv.mkDerivation {
    name = "font-awesome-6-pro";
    src = ../../../fonts;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp $src/Font-Awesome-6-Pro-Solid.otf $out/share/fonts/opentype/
      cp $src/Font-Awesome-6-Pro-Regular.otf $out/share/fonts/opentype/
    '';
  };
  alfa-slab-one = pkgs.stdenv.mkDerivation {
    name = "alfa-slab-one";
    src = ../../../fonts;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src/AlfaSlabOne-Regular.ttf $out/share/fonts/truetype/
    '';
  };
in
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      inter
      font-awesome-6-pro
      alfa-slab-one
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "Inter"
          "Noto Serif"
          "Noto Color Emoji"
          "Font Awesome 6 Pro Solid"
        ];
        sansSerif = [
          "Inter"
          "Noto Sans"
          "Noto Color Emoji"
          "Font Awesome 6 Pro Solid"
        ];
        monospace = [
          "JetBrainsMono Nerd Font Mono"
          "Noto Color Emoji"
          "Font Awesome 6 Pro Solid"
        ];
        emoji = [
          "Noto Color Emoji"
          "Font Awesome 6 Pro Solid"
        ];
      };
    };
  };
}
