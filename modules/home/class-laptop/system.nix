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

        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/chrome" = [ "zen.desktop" ];
        "text/html" = [ "zen.desktop" ];
        "application/x-extension-htm" = [ "zen.desktop" ];
        "application/x-extension-html" = [ "zen.desktop" ];
        "application/x-extension-shtml" = [ "zen.desktop" ];
        "application/xhtml+xml" = [ "zen.desktop" ];
        "application/x-extension-xhtml" = [ "zen.desktop" ];
        "application/x-extension-xht" = [ "zen.desktop" ];

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

  home.packages = with pkgs; [
    upower
    intel-gpu-tools
    brightnessctl
    wireplumber
  ];
}
