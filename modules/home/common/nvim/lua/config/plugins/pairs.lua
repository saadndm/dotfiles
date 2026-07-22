vim.opt.rtp:append("~/Documents/Tools/blink.lib/")
vim.opt.rtp:append("~/Documents/Tools/blink.pairs/")

require("blink.pairs").setup({
  mappings = {
    tabout = {
      ["<Tab>"] = "forward",
      ["<S-Tab>"] = "backward",
    },
  },
  highlights = {
    groups = {
      "BlinkPairsOrange",
      "BlinkPairsPurple",
      "BlinkPairsBlue",
      "BlinkPairsRed",
      "BlinkPairsYellow",
    },
  },
})
