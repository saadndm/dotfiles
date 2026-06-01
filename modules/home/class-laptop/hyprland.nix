{ pkgs, lib, ... }:
{
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      monitor = [
        "eDP-1,2880x1800@120,auto,2,vrr,1,bitdepth,10"
        "DP-1,2560x1440@180,auto,1.6,vrr,2,bitdepth,10"
        ",preferred,auto,1"
      ];

      env = [
        "EDITOR,nvim"
        "VISUAL,nvim"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,16"
      ];

      render.cm_auto_hdr = true;

      xwayland.force_zero_scaling = true;

      exec-once = [
        "sunsetr"
        "waybar"
        "clipse -listen"
        "ghostty --gtk-single-instance=true --initial-window=false"
        "walker --gapplication-service"
        "hypridle"
        "xsetroot -xcf ~/.local/share/icons/catppuccin-mocha-blue-cursors/cursors/left_ptr 16"
        "[workspace 1 silent] zen-twilight"
      ];

      input = {
        kb_layout = "us";
        kb_options = "caps:escape,compose:ralt";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = 1;
          disable_while_typing = true;
        };
      };

      device = [
        {
          name = "endgame-gear-endgame-gear-hs-dongle";
          accel_profile = "flat";
        }
        {
          name = "endgame-gear-xm2w-4k-v2-wireless-gaming-mouse";
          accel_profile = "flat";
        }
      ];

      gesture = "3, horizontal, workspace";

      "$mainmod" = "SUPER";
      "$terminal" = "ghostty --gtk-single-instance=true +new-window";
      "$browser" = "zen-twilight";

      bind = [
        "$mainmod, f, togglefloating,"
        "$mainmod, f11, fullscreen,"
        "$mainmod, backslash, layoutmsg, togglesplit"
        "$mainmod, w, killactive,"
        "$mainmod, return, exec, $terminal"
        "$mainmod, space, exec, nc -U /run/user/1000/walker/walker.sock"
        "$mainmod, e, exec, kitty --class=Yazi -e yazi"
        "$mainmod, b, exec, $browser"
        "$mainmod, v, exec, kitty --class=Clipse -e clipse"
        "$mainmod shift, c, exec, hyprpicker -a"
        "$mainmod, t, exec, kitty --class=Btop -e btop"
        "$mainmod shift, s, exec, ~/.config/scripts/hyprcap.sh --freeze shot region -w -c"
        "$mainmod, q, exec, ~/.config/scripts/switch-power-profiles.sh"
        "$mainmod, escape, exec, walker -m 'menus:powermenu'"
        "$mainmod, o, exec, obsidian"
        "$mainmod, d, exec, vesktop"
        "$mainmod, comma, exec, makoctl dismiss"
        "$mainmod shift, comma, exec, makoctl dismiss --all"
        "$mainmod ctrl, comma, exec, makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send \"silenced notifications\" || notify-send \"enabled notifications\""

        "ALT, Tab, workspace, previous"

        "$mainmod, h, movefocus, l"
        "$mainmod, l, movefocus, r"
        "$mainmod, j, movefocus, u"
        "$mainmod, k, movefocus, d"

        "$mainmod shift, h, swapwindow, l"
        "$mainmod shift, l, swapwindow, r"
        "$mainmod shift, j, swapwindow, u"
        "$mainmod shift, k, swapwindow, d"

        "$mainmod, 1, workspace, 1"
        "$mainmod, 2, workspace, 2"
        "$mainmod, 3, workspace, 3"
        "$mainmod, 4, workspace, 4"
        "$mainmod, 5, workspace, 5"
        "$mainmod, 6, workspace, 6"
        "$mainmod, 7, workspace, 7"
        "$mainmod, 8, workspace, 8"
        "$mainmod, 9, workspace, 9"
        "$mainmod, 0, workspace, 10"

        "$mainmod shift, 1, movetoworkspace, 1"
        "$mainmod shift, 2, movetoworkspace, 2"
        "$mainmod shift, 3, movetoworkspace, 3"
        "$mainmod shift, 4, movetoworkspace, 4"
        "$mainmod shift, 5, movetoworkspace, 5"
        "$mainmod shift, 6, movetoworkspace, 6"
        "$mainmod shift, 7, movetoworkspace, 7"
        "$mainmod shift, 8, movetoworkspace, 8"
        "$mainmod shift, 9, movetoworkspace, 9"
        "$mainmod shift, 0, movetoworkspace, 10"

        "$mainmod, minus, resizeactive, -100 0"
        "$mainmod, equal, resizeactive, 100 0"
        "$mainmod shift, minus, resizeactive, 0 -100"
        "$mainmod shift, equal, resizeactive, 0 100"

        "$mainmod, m, togglespecialworkspace, magic"
        "$mainmod shift, m, movetoworkspace, special:magic"

        "$mainmod, mouse_down, workspace, e+1"
        "$mainmod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainmod, mouse:272, movewindow"
        "$mainmod, mouse:273, resizewindow"
      ];

      bindel = [
        ",xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5"
        ",xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.5"
        ",xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",xf86audiomicmute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",xf86monbrightnessup, exec, brightnessctl -e4 -n2 set 5%+"
        ",xf86monbrightnessdown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", xf86audionext, exec, playerctl next"
        ", xf86audiopause, exec, playerctl play-pause"
        ", xf86audioplay, exec, playerctl play-pause"
        ", xf86audioprev, exec, playerctl previous"
      ];

      windowrule = [
        "suppress_event maximize, match:class .*"
        "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"
        "float on, match:class ^(Clipse|Impala|Bluetui|Btop|Wiremix|Yazi)"
        "size 622 652, match:class (Clipse|Impala|Bluetui)"
        "size 1200 800, match:class (Btop|Wiremix|Yazi)"
        "workspace 3 silent, match:class obsidian"
        "workspace 4 silent, match:class vesktop"
        "workspace 6 silent, match:class virt-manager"
        "workspace 6 silent, fullscreen on, match:class looking-glass-client"
        "workspace 9 silent, float on, match:class steam"
        "float on, pin on, keep_aspect_ratio on, border_size 0, opacity 1.0 1.0, match:title Picture-in-Picture"
        "tile on, match:class steam, match:title Steam"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = lib.mkForce "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 30deg";
        "col.inactive_border" = lib.mkForce "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 90deg";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 0.95;
        inactive_opacity = 0.80;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = lib.mkForce "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 2;
          popups = true;
          passes = 4;
          vibrancy = 0.1000;
        };
      };

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        preserve_split = true;
        force_split = 2;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        focus_on_activate = true;
        initial_workspace_tracking = 0;
      };
    };
  };
}
