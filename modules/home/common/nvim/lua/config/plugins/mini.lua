return {
  "mini.nvim",
  for_cat = "general.mini",
  event = "DeferredUIEnter",
  after = function(plugin)
    local ai = require("mini.ai")
    local ts = ai.gen_spec.treesitter

    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        F = ts({
          a = "@function.outer",
          i = "@function.inner",
        }),
      }
    })

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

    local gen_loader = require("mini.snippets").gen_loader

    require("mini.snippets").setup({
      snippets = {
        gen_loader.from_lang(),
      },
      mappings = {
        expand = "",
        jump_next = "<Tab>",
        jump_prev = "<S-Tab>"
      }
    })

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

    require("mini.bracketed").setup()
    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },
      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })
    require("mini.jump2d").setup({
      view = {
        dim = true,
        n_steps_ahead = 10
      },
      mappings = {
        start_jumping = "",
      },
    })

    vim.keymap.set("n", "s", function()
      MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
    end)

    require("mini.hipatterns").setup()

    local icons = require("mini.icons")
    icons.setup({
      file = {
        [".keep"]             = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    })
    icons.mock_nvim_web_devicons()

    local statusline = require("mini.statusline")
    local function mode_or_recording(args)
      local rec = vim.fn.reg_recording()
      if rec ~= "" then
        return "Recording @" .. rec, "MiniStatuslineModeNormal"
      end
      return statusline.section_mode(args)
    end
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
            "%<",
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl,                  strings = { search, location } },
          })
        end,
      },
    })
    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
      callback = function()
        vim.cmd("redrawstatus")
      end,
    })
  end,
}
