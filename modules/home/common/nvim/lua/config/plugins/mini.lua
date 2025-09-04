vim.keymap.set("n", "s", function()
  MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end)

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
    }
    )
    require("mini.pairs").setup()
    require("mini.surround").setup()

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
    require("mini.jump").setup()
    require("mini.jump2d").setup({
      view = {
        dim = true
      },
      mappings = {
        start_jumping = "",
      },
    })

    require("mini.animate").setup({
      cursor = {
        enable = false
      }
    })
    require("mini.hipatterns").setup()
    require("mini.indentscope").setup()
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
    require("mini.statusline").setup()
  end,
}
