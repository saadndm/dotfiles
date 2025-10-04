return {
  {
    "ultimate-autopair.nvim",
    for_cat = "general.ultimate-autopair",
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    after = function()
      require("ultimate-autopair").setup {
        internal_pairs = {
          { "(", ")", newline = true,   space = true },
          { "{", "}", newline = true,   space = true },
          { '"', '"' },
          { "<", ">", nft = { "typst" } },
          { "$", "$", space = true,     ft = { "typst" }, newline = true },
          { "*", "*", ft = { "typst" } },
        },
        tabout = {
          enable = true,
          hopout = true,
          map = "<Tab>",
          cmap = "<Tab>"
        }
      }
    end,
  },
}
