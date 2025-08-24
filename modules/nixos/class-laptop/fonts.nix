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
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    inter
    font-awesome-6-pro

    nerd-fonts.jetbrains-mono
  ];
}
