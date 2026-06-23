return {
  "mini.nvim",
  event = "DeferredUIEnter",
  after = function (plugin)
    require("mini.ai").setup()

    require("mini.operators").setup({
      replace = {
        prefix = "<leader>gr",
      },
      multiply = {
        prefix = "<leader>gm",
      },
    })
    vim.keymap.set({ "n", "x" }, "<leader>gR", function ()
      return '"+' .. vim.api.nvim_replace_termcodes("<leader>gr", true, true, true)
    end, { expr = true, remap = true, desc = " Replace operator" }
    )
    vim.keymap.set({ "n", "x" }, "<leader>gRr", function ()
      return '"+' .. vim.api.nvim_replace_termcodes("<leader>grr", true, true, true)
    end, { expr = true, remap = true, desc = " Replace line" }
    )

    require("mini.surround").setup({
      mappings = {
        add = "<leader>sa",
        delete = "<leader>sd",
        find = "<leader>sf",
        find_left = "<leader>sF",
        highlight = "",
        replace = "<leader>sr",
      },
    })

    require("mini.bracketed").setup({
      diagnostic = {
        options = { float = false },
      },
    })

    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = { "n", "x" }, keys = "<Leader>" },
        -- `[` and `]` keys
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        -- `g` key
        { mode = { "n", "x" }, keys = "g" },
        -- Marks
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },
        -- Registers
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },
        -- Window commands
        { mode = "n", keys = "<C-w>" },
        -- `z` key
        { mode = { "n", "x" }, keys = "z" },
      },
      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })

    local minidiff = require("mini.diff")
    minidiff.setup({
      view = {
        style = "sign",
        signs = { add = "▎", change = "▎", delete = "" },
        priority = 0,
      },
    })
    vim.keymap.set("n", "<leader>go", function ()
      minidiff.toggle_overlay(0)
    end, { desc = "Toggle mini.diff Overlay" }
    )

    require("mini.input").setup()

    require("mini.hipatterns").setup()

    require("mini.icons").setup()

    local statusline = require("mini.statusline")
    statusline.setup()
    local function mode_or_recording(args)
      local rec = vim.fn.reg_recording()
      if rec ~= "" then
        return "Recording @" .. rec, "MiniStatuslineModeNormal"
      end
      return statusline.section_mode(args)
    end

    local lsp_work, lsp_last_active, lsp_timer_active = {}, {}, false
    local lsp_spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local lsp_progress_grace_ms = 100

    local function lsp_is_active(client)
      local now = vim.uv.hrtime()
      return (lsp_work[client.id] or 0) > 0
        or (lsp_last_active[client.id] and (now - lsp_last_active[client.id]) / 1e6 < lsp_progress_grace_ms)
    end

    local function lsp_redraw()
      local active = false
      for _, client in ipairs(vim.lsp.get_clients()) do
        active = active or lsp_is_active(client)
      end
      vim.cmd.redrawstatus()
      if active then
        vim.defer_fn(lsp_redraw, 80)
      else
        lsp_timer_active = false
      end
    end

    local function lsp_progress()
      local parts, seen = {}, {}
      local frame = lsp_spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #lsp_spinner + 1]

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if not seen[client.name] and lsp_is_active(client) then
          table.insert(parts, frame .. " " .. client.name)
          seen[client.name] = true
        end
      end

      return table.concat(parts, " ")
    end

    vim.api.nvim_create_autocmd("LspProgress", {
      group = vim.api.nvim_create_augroup("ministatusline_lsp_progress", { clear = true }),
      callback = function (ev)
        local kind = ev.data.params.value.kind
        local client_id = ev.data.client_id
        local change = kind == "begin" and 1 or kind == "end" and -1 or 0

        lsp_work[client_id] = math.max((lsp_work[client_id] or 0) + change, 0)
        lsp_last_active[client_id] = vim.uv.hrtime()
        if not lsp_timer_active then
          lsp_timer_active = true
          lsp_redraw()
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
      callback = function ()
        vim.cmd("redrawstatus")
      end,
    })
    statusline.setup({
      content = {
        active = function ()
          local mode, mode_hl = mode_or_recording({ trunc_width = 120 })
          local git = statusline.section_git({ trunc_width = 40 })
          local diff = statusline.section_diff({ trunc_width = 75 })
          local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
          local lsp = statusline.section_lsp({ trunc_width = 75 })
          local progress = lsp_progress()
          local filename = statusline.section_filename({ trunc_width = 140 })
          local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
          local location = statusline.section_location({ trunc_width = 75 })
          local search = statusline.section_searchcount({ trunc_width = 75 })

          return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<",  -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",  -- End left alignment
            { hl = "MiniStatuslineDevinfo", strings = { progress } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    })

    require("mini.tabline").setup()

    require("mini.test").setup()
  end,
}
