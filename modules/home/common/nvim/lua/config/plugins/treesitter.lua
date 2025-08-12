return {
  {
    "nvim-treesitter",
    for_cat = 'general.treesitter',
    event = "DeferredUIEnter",
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-treesitter-textobjects")
      vim.cmd.packadd("nvim-treesitter-context")
      vim.cmd.packadd("nvim-treesitter-textsubjects")
    end,
    after = function(plugin)
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true, },
        indent = { enable = true, },
      }
      require('treesitter-context').setup {
        max_lines = 3,
        mode = "topline"
      }
    end,
  },
}
