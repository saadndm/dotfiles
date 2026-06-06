require("startup")
require("binds")
require("monitors")
require("animations")
require("windowrules")

hl.config({
  render = {
    cm_auto_hdr = true,
  },
  xwayland = {
    force_zero_scaling = true,
  },
  input = {
    kb_layout = "us",
    kb_options = "caps:escape,compose:ralt",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      disable_while_typing = true,
    },
  },
  general = {
    gaps_in = 3,
    gaps_out = 6,
    border_size = 2,
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
    col = {
      active_border = {
        colors = {
          "rgb(8aadf4)",
          "rgb(24273A)",
          "rgb(24273A)",
          "rgb(8aadf4)",
        },
        angle = 30,
      },
      inactive_border = {
        colors = {
          "rgb(24273A)",
          "rgb(24273A)",
          "rgb(24273A)",
          "rgb(24273A)",
        },
        angle = 90,
      },
    },
  },
  decoration = {
    rounding = 10,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,
    shadow = {
      enabled = true,
      range = 32,
      render_power = 2,
      color = "rgba(00000050)",
    },
    blur = {
      enabled = true,
      size = 4,
      passes = 4,
    },
  },
  dwindle = {
    preserve_split = true,
    force_split = 2,
  },
  master = {
    new_status = "master",
  },
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    focus_on_activate = true,
    initial_workspace_tracking = 0,
  },
})

hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "16")
hl.env("XCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("XCURSOR_SIZE", "16")

hl.device({
  name = "endgame-gear-endgame-gear-hs-dongle",
  accel_profile = "flat",
})

hl.device({
  name = "endgame-gear-xm2w-4k-v2-wireless-gaming-mouse",
  accel_profile = "flat",
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})
