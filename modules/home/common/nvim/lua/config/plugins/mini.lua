return {
  "mini.nvim",
  event = "DeferredUIEnter",
  after = function(plugin)
    require("mini.ai").setup()

    require("mini.operators").setup({
      replace = {
        prefix = "<leader>gr",
      },
      multiply = {
        prefix = "<leader>gm"
      }
    })
    vim.keymap.set({ "n", "x" }, "<leader>gR", function()
      return '"+' .. vim.api.nvim_replace_termcodes("<leader>gr", true, true, true)
    end, { expr = true, remap = true, desc = " Replace operator" })
    vim.keymap.set({ "n", "x" }, "<leader>gRr", function()
      return '"+' .. vim.api.nvim_replace_termcodes("<leader>grr", true, true, true)
    end, { expr = true, remap = true, desc = " Replace line" })

    require("mini.surround").setup({
      mappings = {
        add = "<leader>sa",
        delete = "<leader>sd",
        find = "<leader>sf",
        find_left = "<leader>sF",
        highlight = "",
        replace = "<leader>sr",
      }
    })

    require("mini.bracketed").setup({
      diagnostic = {
        options = { float = false }
      },
    })

    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = { "n", "x" }, keys = "<Leader>" },

        -- `[` and `]` keys
        { mode = "n",          keys = "[" },
        { mode = "n",          keys = "]" },

        -- `g` key
        { mode = { "n", "x" }, keys = "g" },

        -- Marks
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },

        -- Registers
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },

        -- Window commands
        { mode = "n",          keys = "<C-w>" },

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
      }
    })
    vim.keymap.set("n", "<leader>go", function()
      minidiff.toggle_overlay(0)
    end, { desc = "Toggle mini.diff Overlay" })

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
    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
      callback = function()
        vim.cmd("redrawstatus")
      end,
    })
    statusline.setup({
      content = {
        active = function()
          local mode, mode_hl = mode_or_recording({ trunc_width = 120 })
          local git           = statusline.section_git({ trunc_width = 40 })
          local diff          = statusline.section_diff({ trunc_width = 75 })
          local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
          local lsp           = statusline.section_lsp({ trunc_width = 75 })
          local filename      = statusline.section_filename({ trunc_width = 140 })
          local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
          local location      = statusline.section_location({ trunc_width = 75 })
          local search        = statusline.section_searchcount({ trunc_width = 75 })

          return statusline.combine_groups({
            { hl = mode_hl,                 strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl,                  strings = { search, location } },
          })
        end,
      },
    })

    require("mini.tabline").setup()

    require("mini.test").setup()
  end,
}
