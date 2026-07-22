require("catppuccin").setup({
  float = {
    transparent = true,
  },
  integrations = {
    blink_pairs = true,
    gitsigns = true,
    mini = true,
    snacks = true,
    diffview = true,
    treesitter_context = true,
    markview = true,
  },
})

vim.cmd.colorscheme("catppuccin")
