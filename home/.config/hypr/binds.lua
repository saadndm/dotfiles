local mainmod = "SUPER"

local function exec(command)
  return hl.dsp.exec_cmd(command)
end

local function key(mods, name)
  if mods == "" then
    return name
  end

  return mods .. " + " .. name
end

hl.bind(key(mainmod, "F"), hl.dsp.window.float())
hl.bind(key(mainmod, "F11"), hl.dsp.window.fullscreen())
hl.bind(key(mainmod, "BACKSLASH"), hl.dsp.layout("togglesplit"))
hl.bind(key(mainmod, "W"), hl.dsp.window.close())
hl.bind(key(mainmod, "RETURN"), exec("ghostty +new-window"))
hl.bind(key(mainmod, "SPACE"), exec("nc -U /run/user/1000/walker/walker.sock"))
hl.bind(key(mainmod, "E"), exec("kitty --class=Yazi -e yazi"))
hl.bind(key(mainmod, "B"), exec("zen-twilight"))
hl.bind(key(mainmod, "V"), exec("kitty --class=Clipse -e clipse"))
hl.bind(key(mainmod .. " + SHIFT", "C"), exec("hyprpicker -a"))
hl.bind(key(mainmod, "T"), exec("kitty --class=Btop -e btop"))
hl.bind(
  key(mainmod .. " + SHIFT", "S"), exec("~/.config/scripts/hyprcap.sh --freeze shot region -w -c")
)
hl.bind(key(mainmod, "Q"), exec("~/.config/scripts/switch-power-profiles.sh"))
hl.bind(key(mainmod, "ESCAPE"), exec("walker -m 'menus:powermenu'"))
hl.bind(key(mainmod, "O"), exec("obsidian"))
hl.bind(key(mainmod, "D"), exec("vesktop"))
hl.bind(key(mainmod, "COMMA"), exec("makoctl dismiss --all"))
hl.bind(key(mainmod .. " + SHIFT", "COMMA"), exec("~/.config/scripts/toggle-notifications.sh"))

hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }))

hl.bind(key(mainmod, "H"), hl.dsp.focus({ direction = "left" }))
hl.bind(key(mainmod, "L"), hl.dsp.focus({ direction = "right" }))
hl.bind(key(mainmod, "J"), hl.dsp.focus({ direction = "down" }))
hl.bind(key(mainmod, "K"), hl.dsp.focus({ direction = "up" }))

hl.bind(key(mainmod .. " + SHIFT", "H"), hl.dsp.window.swap({ direction = "left" }))
hl.bind(key(mainmod .. " + SHIFT", "L"), hl.dsp.window.swap({ direction = "right" }))
hl.bind(key(mainmod .. " + SHIFT", "J"), hl.dsp.window.swap({ direction = "down" }))
hl.bind(key(mainmod .. " + SHIFT", "K"), hl.dsp.window.swap({ direction = "up" }))

for i = 1, 9 do
  hl.bind(key(mainmod, tostring(i)), hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(key(mainmod .. " + SHIFT", tostring(i)), hl.dsp.window.move({ workspace = i }))
end

hl.bind(key(mainmod, "0"), hl.dsp.focus({ workspace = "10" }))
hl.bind(key(mainmod .. " + SHIFT", "0"), hl.dsp.window.move({ workspace = 10 }))

hl.bind(key(mainmod, "MINUS"), hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(key(mainmod, "EQUAL"), hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(
  key(mainmod .. " + SHIFT", "MINUS"),
  hl.dsp.window.resize({
    x = 0,
    y = -100,
    relative = true,
  })
)
hl.bind(
  key(mainmod .. " + SHIFT", "EQUAL"),
  hl.dsp.window.resize({
    x = 0,
    y = 100,
    relative = true,
  })
)

hl.bind(key(mainmod, "M"), hl.dsp.workspace.toggle_special("magic"))
hl.bind(key(mainmod .. " + SHIFT", "M"), hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(key(mainmod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(key(mainmod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5"), {
  repeating = true,
})
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.5"), {
  repeating = true,
})
hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", exec("brightnessctl -e4 -n2 set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", exec("brightnessctl -e4 -n2 set 5%-"), { repeating = true })

hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })
