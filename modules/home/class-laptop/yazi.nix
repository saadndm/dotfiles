{ pkgs, inputs, ... }:
{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default.override {
      _7zz = pkgs._7zz-rar;
    };
    enableFishIntegration = true;
    settings = {
      mgr = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "mtime";
        sort_sensitive = false;
        sort_reverse = true;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        image_filter = "triangle";
        image_quality = 75;
        tab_size = 2;
        max_width = 1200;
        max_height = 1000;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };
      opener = {
        mpv = [
          {
            run = "mpv \"$@\"";
            desc = "MPV";
            orphan = true;
            for = "unix";
          }
        ];
        imv = [
          {
            run = "imv \"$@\"";
            desc = "imv";
            orphan = true;
            for = "unix";
          }
        ];
        pinta = [
          {
            run = "pinta \"$@\"";
            desc = "Pinta";
            orphan = true;
            for = "unix";
          }
        ];
        zathura = [
          {
            run = "zathura \"$@\"";
            desc = "Zathura";
            orphan = true;
            for = "unix";
          }
        ];
        xournalpp = [
          {
            run = "xournalpp \"$@\"";
            desc = "Xournalpp";
            orphan = true;
            for = "unix";
          }
        ];
      };
      open.prepend_rules = [
        {
          mime = "image/*";
          use = [
            "imv"
            "pinta"
          ];
        }
        {
          mime = "{audio,video}/*";
          use = [ "mpv" ];
        }
        {
          mime = "application/pdf";
          use = [
            "zathura"
            "xournalpp"
          ];
        }
      ];
    };
    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = "l";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = "M";
            run = "plugin mount";
          }
          {
            on = "+";
            run = "plugin zoom 1";
          }
          {
            on = "-";
            run = "plugin zoom -1";
          }
        ];
      };
    };
    plugins = {
      inherit (pkgs.yaziPlugins)
        git
        sudo
        mount
        smart-enter
        ;
      zoom = pkgs.stdenv.mkDerivation {
        name = "yazi-plugin-zoom";

        src = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "plugins";
          rev = "d7588f6d29b5998733d5a71ec312c7248ba14555";
          sha256 = "sha256-9+58QhdM4HVOAfEC224TrPEx1N7F2VLGMxKVLAM4nJw=";
        };

        installPhase = ''
          mkdir -p $out
          cp -rL zoom.yazi/* $out/
        '';
      };
    };
  };
}
