vim.keymap.set({ "n", "x", "o" }, "<CR>", '<Cmd>lua require("config.plugins.nvim-jump").start()<CR>', { desc = "Jump" })

local fn = vim.fn
local api = vim.api

local M = {}
local NS = api.nvim_create_namespace("jump")
local CR = api.nvim_replace_termcodes("<Cr>", true, true, true)
local ESC = api.nvim_replace_termcodes("<Esc>", true, true, true)
local LABELS = {}
local CONFIG = {
  -- The labels that may be used, in order of their preference.
  labels = "fdsaghjklrewqtyuiopvcxzbnm",

  -- The highlight group to use for match highlights.
  search = "Search",

  -- The highlight group to use for labels.
  label = "FlashLabel",
}

local function search(pattern, lines, start_line, matches)
  local lower = pattern == pattern:lower()

  for idx, line in ipairs(lines) do
    local lnum = start_line + idx - 1
    local line = lower and line:lower() or line

    if #line > 0 then
      local col = 1

      while true do
        local start, stop = line:find(pattern, col, true)

        if not start then
          break
        end

        col = stop + 1
        table.insert(matches, {
          line = lnum - 1,
          start_col = start - 1,
          end_col = stop,
          line_index = idx,
        })
      end
    end
  end
end

local function available_labels(lines, matches)
  local avail = {}

  for _, char in ipairs(LABELS) do
    avail[char] = true
  end

  -- Disable all the labels that conflict with any of the characters that may be
  -- matched by the next input.
  for _, match in ipairs(matches) do
    local next_col = match.end_col + 1
    local next_char = lines[match.line_index]:sub(next_col, next_col):lower()

    avail[next_char] = false
  end

  return avail
end

function M.start()
  local win = api.nvim_get_current_win()
  local buf = api.nvim_win_get_buf(win)
  local info = fn.getwininfo(win)[1]
  local top = info.topline
  local lines = api.nvim_buf_get_lines(buf, top - 1, info.botline, true)
  local view = fn.winsaveview()
  local active = {}
  local selected
  local incsearch = vim.o.incsearch
  local hlsearch = vim.o.hlsearch
  local jump_active = vim.g.nvim_jump_active

  vim.o.incsearch = false
  vim.o.hlsearch = false
  vim.g.nvim_jump_active = true

  local function refresh(chars)
    local matches = {}
    active = {}
    api.nvim_buf_clear_namespace(buf, NS, 0, -1)

    if #chars > 0 then
      search(chars, lines, top, matches)

      local avail = available_labels(lines, matches)

      for _, match in ipairs(matches) do
        local label = nil

        for _, cur in ipairs(LABELS) do
          if avail[cur] then
            label = cur
            avail[cur] = false
            break
          end
        end

        vim.hl.range(
          buf, NS, CONFIG.search, { match.line, match.start_col }, { match.line, match.end_col }, { priority = 200 }
        )

        if label then
          active[label] = { match.line + 1, match.start_col }
          api.nvim_buf_set_extmark(buf, NS, match.line, match.start_col, {
            virt_text = { { label, CONFIG.label } },
            virt_text_pos = "overlay",
            priority = 201,
          })
        end
      end
    end

    vim.cmd.redraw()
  end

  vim.on_key(function (key, typed)
    local jump_to = active[key] or active[typed]

    if not jump_to and key ~= CR and typed ~= CR then
      return
    end

    selected = jump_to

    if not selected then
      for _, label in ipairs(LABELS) do
        selected = active[label]

        if selected then
          break
        end
      end
    end

    api.nvim_input(ESC)

    return ""
  end, NS)

  local autocmd
  autocmd = api.nvim_create_autocmd({ "CmdlineChanged", "CmdlineLeave" }, {
    callback = function (args)
      if args.event == "CmdlineChanged" then
        refresh(fn.getcmdline())
        return
      end

      vim.schedule(function ()
        vim.on_key(nil, NS)

        api.nvim_del_autocmd(autocmd)
        api.nvim_buf_clear_namespace(buf, NS, 0, -1)
        vim.o.incsearch = incsearch
        vim.o.hlsearch = hlsearch
        vim.g.nvim_jump_active = jump_active
        vim.cmd.nohlsearch()

        if api.nvim_win_is_valid(win) then
          api.nvim_set_current_win(win)
          fn.winrestview(view)

          if selected then
            vim.cmd("normal! m'")
            api.nvim_win_set_cursor(win, selected)
          end
        end

        vim.cmd.redraw()
      end)
    end,
  })

  api.nvim_input("/")
end

function M.setup(opts)
  if opts then
    CONFIG = vim.tbl_extend("force", CONFIG, opts)
  end

  LABELS = fn.split(CONFIG.labels, "\\zs")
end

M.setup({
  label = "MiniJump2dSpotUnique",
})

return M
