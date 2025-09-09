return {
  {
    "nvim-treesitter",
    for_cat = "general.treesitter",
    event = "DeferredUIEnter",
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-treesitter-textobjects")
      vim.cmd.packadd("nvim-treesitter-context")
    end,
    after = function(plugin)
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true, },
        indent = { enable = true, },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      }
      require("treesitter-context").setup {
        max_lines = 3,
        mode = "topline"
      }
    end,
  },
}
