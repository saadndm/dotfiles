{ pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      theme = "omarchy";
      themePackages = [
        (pkgs.stdenv.mkDerivation {
          pname = "plymouth-theme-omarchy";
          version = "1.0";
          src = ./../../plymouth;
          installPhase = ''
            themeDir=$out/share/plymouth/themes/omarchy
            mkdir -p $themeDir
            cp -r $src/* $themeDir/

            # Patch omarchy.plymouth to use store paths instead of /usr/share
            sed -i "s|/usr/share/plymouth/themes/omarchy|$themeDir|g" \
              $themeDir/omarchy.plymouth
          '';
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  systemd.services."plymouth-quit-wait".enable = false;
  systemd.services."plymouth-quit".unitConfig.After = [ "multi-user.target" ];
}
