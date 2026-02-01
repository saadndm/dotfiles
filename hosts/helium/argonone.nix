{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.hardware.argonone;

  argonone-pi5 = pkgs.argononed.overrideAttrs (old: {
    version = "0.5.x";

    src = pkgs.fetchFromGitLab {
      owner = "DarkElvenAngel";
      repo = "argononed";
      rev = "0.5.x";
      hash = "sha256-Uv4cyo3FcHIr4N9s+A0ZMmQU7KYAiClcMOtZPXA6GQQ=";
    };

    patches = [ ];

    postPatch = ''
      sed -i -E 's/void\s*\*\s*_timer_thread\s*\(\)/void *_timer_thread(void *args)/g' src/common/event_timer.c
      sed -i -E 's/void\s*\*\s*_ipc_thread\s*\(\)/void *_ipc_thread(void *args)/g' src/daemon/argonone_ipc.c
    '';
  });
in
{
  disabledModules = [ "services/hardware/argonone.nix" ];

  options.services.hardware.argonone = {
    enable = lib.mkEnableOption "the driver for Argon One Raspberry Pi case fan and power button";
    package = lib.mkOption {
      default = argonone-pi5;
      description = "The updated ArgonOne daemon package";
    };
  };

  config = lib.mkMerge [
    { services.hardware.argonone.enable = lib.mkDefault true; }

    (lib.mkIf cfg.enable {
      hardware.i2c.enable = true;
      environment.systemPackages = [ cfg.package ];

      environment.etc."argononed.conf".text = ''
        flags = 0x04
        fans = 10, 55, 100
        temps = 55, 60, 65
        hysteresis = 5
      '';

      systemd.services.argononed = {
        description = "Argon One Fan and Button Daemon Service";
        after = [ "sysinit.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "forking";
          ExecStart = "${cfg.package}/bin/argononed";
          PIDFile = "/run/argononed.pid";
          Restart = "on-failure";
          RestartSec = "5";
        };
      };
    })
  ];
}
