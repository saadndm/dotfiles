{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  programs = {
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        background_opacity = lib.mkForce "0.8";
      };
    };

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

    zathura = {
      enable = true;
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    wpaperd = {
      enable = true;
      settings = {
        default = {
          duration = "30m";
          mode = "center";
        };
        any.path = "~/dotfiles/wallpapers";
      };
    };
  };

  home.packages = with pkgs; [
    inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default

    jmtpfs
    impala
    clipse
    waybar
    mako
    wiremix
    hyprpicker
    yt-dlp
    libqalculate
    bluetui
    hypridle
    walker
    obsidian
    xournalpp
    pinta
    typst
    vesktop
    oama
    hyprlock
    hypridle
    imv
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-21
      ];
    })
    dragon-drop
    xorg.xsetroot
    racket
    upower
    intel-gpu-tools
    brightnessctl
    wireplumber
    wl-clipboard
    libnotify
    wayfreeze
    slurp
    grim
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.uk_UA
    sunsetr
    bruno
    jetbrains.idea-ultimate
    virt-manager
    ventoy-full-gtk
    looking-glass-client
    obs-studio
    kdePackages.kdenlive
    seahorse
  ];
}
