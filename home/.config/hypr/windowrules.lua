hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  match = { class = "^(Clipse|Impala|Bluetui|Btop|Wiremix|Yazi)" },
  float = true,
})

hl.window_rule({
  match = { class = "(Clipse|Impala|Bluetui)" },
  size = { 622, 652 },
})

hl.window_rule({
  match = { class = "(Btop|Wiremix|Yazi)" },
  size = { 1200, 800 },
})

hl.window_rule({
  match = { title = "Picture-in-Picture" },
  float = true,
  pin = true,
  keep_aspect_ratio = true,
  border_size = 0,
  opacity = "1.0 1.0",
})

hl.layer_rule({
  match = { namespace = "^(walker|wayfreeze|selection)$" },
  no_anim = true,
})

hl.window_rule({
  match = { class = "obsidian" },
  workspace = "3 silent",
})

hl.window_rule({
  match = { class = "vesktop" },
  workspace = "4 silent",
})

hl.window_rule({
  match = { title = "^Virtual Machine Manager$" },
  workspace = "6 silent",
})

hl.window_rule({
  match = { class = "^looking-glass-client$" },
  workspace = "6 silent",
  fullscreen = true,
})

hl.window_rule({
  match = { class = "steam" },
  workspace = "9 silent",
  float = true,
})
