{
  lib,
  pkgs,
  perSystem,
  ...
}:
{
  programs = {
    kitty = {
      enable = true;
      font.name = "JetBrainsMono Nerd Font Mono";
      shellIntegration.enableFishIntegration = true;
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        background_opacity = lib.mkForce "0.8";
      };
    };
    mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
      ];
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
    sioyek = {
      enable = true;
    };
    obs-studio = {
      enable = true;
    };
    ghostty = {
      enable = true;
      package = perSystem.ghostty.default;
      enableFishIntegration = true;
      settings = {
        custom-shader = "./shaders/cursor_warp.glsl";
        font-family = "JetBrainsMono Nerd Font Mono";
        confirm-close-surface = false;
        quit-after-last-window-closed = false;
        window-padding-balance = true;
        window-padding-color = "background";
        clipboard-paste-protection = false;
        cursor-style = "bar";
        background-opacity = 0.8;
        background-blur = true;
        shell-integration-features = "cursor,no-sudo,title,ssh-env,ssh-terminfo,path";
        keybind = [
          "ctrl+backspace=text:\\x17"
          "ctrl+enter=unbind"
        ];
      };
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
    clipse = {
      enable = true;
      settings = {
        maxHistory = 1000;
        keyBindings = {
          up = "k";
          down = "j";
          nextPage = "l";
          prevPage = "h";
          remove = "x";
          quit = "q,esc";
        };
        imageDisplay = {
          type = "kitty";
          scaleX = 25;
          scaleY = 30;
          heightCut = 4;
        };
      };
    };
  };

  home.packages = with pkgs; [
    impala
    # TODO: Remove once waybar releases version containing hyprland workspaces fix
    ((waybar.override { cavaSupport = false; }).overrideAttrs (finalAttrs: {
      src = fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = "05945748dccce28bf96d26d8f64a9e69a8dd49ba";
        hash = "sha256-51R3mIt8cLNvh/X5qe9vOqeJCj0U9KRyemVE5y+OhiU=";
      };
    }))
    mako
    wiremix
    hyprpicker
    yt-dlp
    libqalculate
    bluetui
    walker
    obsidian
    xournalpp
    pinta
    typst
    vesktop
    hyprlock
    hypridle
    imv
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-25
      ];
      additionalLibs = with pkgs; [
        libxkbcommon
        fontconfig
      ];
    })
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
    jetbrains.idea
    virt-manager
    (looking-glass-client.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "gnif";
        repo = "LookingGlass";
        rev = "fc6a728bb775f47733b2d7919047de3a1bf116ba";
        hash = "sha256-zgZBjevnJX/syZytyft//0HO8sx/vVYfOe9SkUZztJ4=";
        fetchSubmodules = true;
      };
    }))
    kdePackages.kdenlive
    seahorse
    heroic
    android-tools
    qbittorrent
  ];
}
