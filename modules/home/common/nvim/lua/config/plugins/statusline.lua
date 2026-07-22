local statusline = require("mini.statusline")

-- Macro recording message
local recording_register = ""

local function mode_or_recording(args)
  if recording_register ~= "" then
    return "Recording @" .. recording_register, "MiniStatuslineModeNormal"
  end

  return statusline.section_mode(args)
end

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  callback = function (ev)
    if ev.event == "RecordingEnter" then
      recording_register = vim.fn.reg_recording()
    else
      recording_register = ""
    end
  end,
})

-- LSP loading indicator
local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local timer_active = false

local function has_progress()
  local lsp = package.loaded["vim.lsp"]
  if not lsp then return false end

  for _, client in ipairs(lsp.get_clients()) do
    if next(client.progress.pending) then
      return true
    end
  end
  return false
end

local function redraw_progress()
  vim.cmd.redrawstatus()

  if has_progress() then
    vim.defer_fn(redraw_progress, 80)
  else
    timer_active = false
  end
end

local function lsp_progress()
  local lsp = package.loaded["vim.lsp"]
  if not lsp then return "" end

  local frame = spinner[math.floor(vim.uv.hrtime() / 8e7) % #spinner + 1]
  local parts = {}

  for _, client in ipairs(lsp.get_clients({ bufnr = 0 })) do
    if next(client.progress.pending) then
      parts[#parts + 1] = frame .. " " .. client.name
    end
  end

  return table.concat(parts, " ")
end

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function ()
    if timer_active then return end

    timer_active = true
    redraw_progress()
  end,
})

-- Diagnostic severity color
local function setup_diagnostic_hls()
  local normal = vim.api.nvim_get_hl(0, {
    name = "Normal",
    link = false,
  })

  for _, name in ipairs({
    "DiagnosticError",
    "DiagnosticWarn",
    "DiagnosticInfo",
    "DiagnosticHint",
  }) do
    local diagnostic = vim.api.nvim_get_hl(0, {
      name = name,
      link = false,
    })

    vim.api.nvim_set_hl(0, "MiniStatusline" .. name, {
      fg = normal.bg,
      bg = diagnostic.fg,
      bold = true,
    })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = setup_diagnostic_hls,
})

setup_diagnostic_hls()

local function diagnostic_hl()
  local diagnostic = package.loaded["vim.diagnostic"]
  if not diagnostic then return "MiniStatuslineDevinfo" end

  local highest

  for _, item in ipairs(diagnostic.get(0)) do
    if highest == nil or item.severity < highest then
      highest = item.severity
    end
  end

  return ({
    [diagnostic.severity.ERROR] = "MiniStatuslineDiagnosticError",
    [diagnostic.severity.WARN] = "MiniStatuslineDiagnosticWarn",
    [diagnostic.severity.INFO] = "MiniStatuslineDiagnosticInfo",
  })[highest] or "MiniStatuslineDevinfo"
end

statusline.setup({
  content = {
    active = function ()
      local mode, mode_hl = mode_or_recording({ trunc_width = 120 })
      local git = statusline.section_git({ trunc_width = 40 })
      local diagnostics = package.loaded["vim.diagnostic"]
        and statusline.section_diagnostics({ trunc_width = 75 })
        or ""
      local lsp = package.loaded["vim.lsp"]
        and statusline.section_lsp({ trunc_width = 75 })
        or ""
      local filename = statusline.section_filename({ trunc_width = 140 })
      local fileinfo = statusline.section_fileinfo({ trunc_width = math.huge })
      local location = statusline.section_location({ trunc_width = 75 })
      local search = statusline.section_searchcount({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, lsp } },
        { hl = diagnostic_hl(), strings = { diagnostics } },
        "%<",  -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",  -- End left alignment
        { hl = "MiniStatuslineDevinfo", strings = { lsp_progress() } },
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end,
  },
})
