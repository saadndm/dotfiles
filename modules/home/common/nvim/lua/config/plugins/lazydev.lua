return {
  {
    "lazydev.nvim",
    ft = "lua",
    after = function ()
      require("lazydev").setup({
        library = {
          "~/Documents/mathlive.nvim",
        },
      })
    end,
  },
}
