{
  inputs,
  pkgs,
  config,
  ...
}:
{
  xdg.configFile."racket/racket-prefs.rktd" = {
    force = true;
    onChange = ''
      ~/.config/racket/drracket-wakatime.sh
    '';
    source = "${inputs.self}/home/.config/racket/racket-prefs.rktd";
  };

  xdg.configFile."racket/drracket-wakatime.sh" = {
    executable = true;
    source = pkgs.writeShellScript "drracket-wakatime" ''
      #!/usr/bin/env bash

      WAKATIME_API_KEY=$(cat "${config.age.secrets.wakatime.path}")

      sed -i "s#WAKATIME_API_KEY_PLACEHOLDER#''${WAKATIME_API_KEY}#" "$HOME/.config/racket/racket-prefs.rktd"
    '';
  };

  home.packages = with pkgs; [
    racket
  ];
}
