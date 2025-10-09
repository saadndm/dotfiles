{ pkgs, ... }:
{
  xdg = {
    desktopEntries."yazi" = {
      name = "Yazi";
      exec = "kitty --class=Yazi -e yazi %f";
      type = "Application";
      categories = [
        "Utility"
        "FileManager"
        "TerminalEmulator"
      ];
      mimeType = [
        "application/zip"
        "inode/directory"
      ];
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/discord" = [ "vesktop.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "text/plain" = [ "nvim.desktop" ];

        "application/zip" = [ "yazi.desktop" ];
        "inode/directory" = [ "yazi.desktop" ];

        "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/chrome" = [ "zen-twilight.desktop" ];
        "text/html" = [ "zen-twilight.desktop" ];
        "application/x-extension-htm" = [ "zen-twilight.desktop" ];
        "application/x-extension-html" = [ "zen-twilight.desktop" ];
        "application/x-extension-shtml" = [ "zen-twilight.desktop" ];
        "application/xhtml+xml" = [ "zen-twilight.desktop" ];
        "application/x-extension-xhtml" = [ "zen-twilight.desktop" ];
        "application/x-extension-xht" = [ "zen-twilight.desktop" ];

        "image/png" = [ "imv.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "image/bmp" = [ "imv.desktop" ];
        "image/tiff" = [ "imv.desktop" ];

        "video/mp4" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/x-flv" = [ "mpv.desktop" ];
        "video/x-ms-wmv" = [ "mpv.desktop" ];
        "video/mpeg" = [ "mpv.desktop" ];
        "video/ogg" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/3gpp" = [ "mpv.desktop" ];
        "video/3gpp2" = [ "mpv.desktop" ];
        "video/x-ms-asf" = [ "mpv.desktop" ];
        "video/x-ogm+ogg" = [ "mpv.desktop" ];
        "video/x-theora+ogg" = [ "mpv.desktop" ];
        "application/ogg" = [ "mpv.desktop" ];
      };

      associations.added = {
        "application/pdf" = [ "xournalpp.desktop" ];
        "image/png" = [ "pinta.desktop" ];
        "image/jpeg" = [ "pinta.desktop" ];
        "image/gif" = [ "pinta.desktop" ];
        "image/webp" = [ "pinta.desktop" ];
        "image/bmp" = [ "pinta.desktop" ];
        "image/tiff" = [ "pinta.desktop" ];
      };
    };
  };

  systemd.user.services."burn-in" = {
    Service = {
      ExecStart = ''
        /run/current-system/sw/bin/bash /home/bridgesense/.config/scripts/burn-in.sh switch
      '';
    };
  };

  systemd.user.timers."burn-in" = {
    Timer = {
      OnCalendar = "*:0/30";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
