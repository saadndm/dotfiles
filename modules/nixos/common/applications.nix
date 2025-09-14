{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (pkgs.runCommand "ghostty-terminfo" { buildInputs = [ pkgs.ncurses ]; } ''
      mkdir -p $out/share/terminfo
      ${pkgs.ncurses}/bin/infocmp -x -A ${inputs.ghostty.packages.${pkgs.system}.default}/share/terminfo \
        xterm-ghostty | ${pkgs.ncurses}/bin/tic -x -o $out/share/terminfo -
    '')
    compose2nix
  ];
}
