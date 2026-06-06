local laptop = "eDP-1"
local aoc_desc = "AOC Q27G3XMN 1APR9UA001942"

local function find_monitor(identifier)
  for _, mon in ipairs(hl.get_monitors() or {}) do
    if mon.description == identifier or mon.name == identifier then
      return mon.name
    end
  end

  return nil
end

local function enable_unknown_outputs()
  hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
  })
end

local function use_laptop()
  hl.monitor({
    output = laptop,
    disabled = false,
    mode = "2880x1800@120Hz",
    position = "0x0",
    scale = 2,
    vrr = 1,
    bitdepth = 10,
  })

  hl.exec_cmd("~/.config/scripts/hyproled.sh -a 0:0:2880:67 -s -m 0")
end

local function use_aoc(output)
  hl.monitor({
    output = output,
    disabled = false,
    mode = "2560x1440@180Hz",
    position = "0x0",
    scale = 1.6,
    bitdepth = 10,
  })

  hl.monitor({
    output = laptop,
    disabled = true,
  })

  hl.exec_cmd("~/.config/scripts/burn-in.sh disable")
end

local function apply_outputs()
  enable_unknown_outputs()

  local aoc_output = find_monitor(aoc_desc)

  if aoc_output then
    use_aoc(aoc_output)
  else
    use_laptop()
  end
end

hl.on("hyprland.start", apply_outputs)
hl.on("monitor.added", apply_outputs)
hl.on("monitor.removed", apply_outputs)

apply_outputs()
