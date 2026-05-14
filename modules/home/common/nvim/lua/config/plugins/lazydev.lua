return {
  {
    "lazydev.nvim",
    ft = "lua",
    after = function ()
      require("lazydev").setup({
        library = {
          "~/Documents/Projects/mathlive.nvim"
        }
      })
    end
  }
}
