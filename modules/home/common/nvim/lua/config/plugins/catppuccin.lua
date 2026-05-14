return {
  "catppuccin-nvim",
  lazy = false,
  after = function ()
    require("catppuccin").setup({
      float = {
        transparent = true
      }
    })

    vim.cmd.colorscheme("catppuccin")
  end
}
