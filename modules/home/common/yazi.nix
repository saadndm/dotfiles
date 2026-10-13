{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
    enableFishIntegration = true;
    initLua = ''
      require("zoxide"):setup {
        update_db = true,
      }
    '';
    settings = {
      mgr = {
        sort_by = "mtime";
        sort_reverse = true;
      };
      preview = {
        max_width = 1200;
        max_height = 1000;
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
        sioyek = [
          {
            run = "sioyek \"$@\"";
            desc = "Sioyek";
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
            "sioyek"
            "xournalpp"
          ];
        }
      ];
      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];
    };
    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = "?";
            run = "help";
            desc = "Open help";
          }
          {
            on = "~";
            run = "noop";
          }
          {
            on = "<F1>";
            run = "noop";
          }
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
            on = "=";
            run = "plugin zoom 1";
          }
          {
            on = "-";
            run = "plugin zoom -1";
          }
          {
            on = [
              "g"
              "P"
            ];
            run = [
              "shell '$HOME/.config/scripts/kdeconnect-mount.sh -n \"OnePlus 12\" /mnt/phone' --block"
              "cd /mnt/phone"
            ];
            desc = "Mount & go to phone";
          }
          {
            on = [
              "g"
              "m"
            ];
            run = "cd ~/.local/share/PrismLauncher/instances";
            desc = "Go to minecraft";
          }
          {
            on = [
              "g"
              "c"
            ];
            run = "cd ~/Documents/Obsidian/Saad/Courses/";
            desc = "Go to courses";
          }
          {
            on = [
              "g"
              "p"
            ];
            run = "cd ~/Projects/";
            desc = "Go to projects";
          }
        ];
      };
    };
    plugins = {
      inherit (pkgs.yaziPlugins)
        sudo
        mount
        smart-enter
        zoom
        ;
      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;
        settings = {
          order = 1500;
        };
      };
    };
  };
}
