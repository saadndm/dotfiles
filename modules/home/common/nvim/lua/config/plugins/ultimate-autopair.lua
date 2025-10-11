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
          { "(", ")",  newline = true,   space = true },
          { "{", "}",  newline = true,   space = true, nft = { "nix" } },
          { "{", "};", newline = true,   space = true, ft = { "nix" } },
          { "[", "]",  newline = true,   space = true, nft = { "nix" } },
          { "[", "];", newline = true,   space = true, ft = { "nix" } },
          { '"', '"' },
          { "<", ">",  nft = { "typst" } },
          { "$", "$",  newline = true,   space = true, ft = { "typst" } },
          { "*", "*",  ft = { "typst" } },
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
