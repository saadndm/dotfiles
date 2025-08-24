{ inputs, pkgs, ... }:
{
  programs = {
    mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
          ];

          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
          };
        }
      );

      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo[height<=2160][vcodec^=vp9.2]+bestaudio/best";
        demuxer-max-bytes = "1G";
        demuxer-max-back-bytes = "200M";
        demuxer-readahead-secs = 60;
        vo = "gpu-next";
        gpu-api = "vulkan";
        target-colorspace-hint = "yes";
        tone-mapping = "clip";
        hdr-compute-peak = "no";
      };
    };
  };
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  home.packages = with pkgs; [
    inputs.ghostty.packages.${pkgs.system}.default
    jmtpfs
    impala
    clipse
    waybar
    mako
    wiremix
    hyprpicker
    yt-dlp
    hyprpaper
    libqalculate
    bluetui
    hypridle
    walker
    obsidian
    xournalpp
    evince
    pinta
    vesktop
  ];
}
