{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age = {
    identityPaths = [ "/home/bridgesense/.ssh/id_ed25519" ];
    secrets = {
      bridgesensemc-gmail = {
        file = ../../../secrets/bridgesensemc-gmail.age;
      };
      saad29nadeem-gmail = {
        file = ../../../secrets/saad29nadeem-gmail.age;
      };
      wakatime = {
        file = ../../../secrets/wakatime.age;
      };
    };
  };

  xdg.configFile."racket/drracket-wakatime.sh" = {
    executable = true;
    source = pkgs.writeShellScript "drracket-wakatime" ''
      #!/usr/bin/env bash

      WAKATIME_API_KEY=$(cat "${config.age.secrets.wakatime.path}")

      sed -i "s#WAKATIME_API_KEY_PLACEHOLDER#''${WAKATIME_API_KEY}#" "$HOME/.config/racket/racket-prefs.rktd"
    '';
  };
}
