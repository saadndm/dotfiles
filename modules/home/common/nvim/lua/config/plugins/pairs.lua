return {
  "blink.pairs",
  event = "InsertEnter",
  load = function ()
    vim.opt.rtp:append("~/Documents/Tools/blink.pairs/")
  end,
  after = function ()
    require("blink.pairs").setup({
      mappings = {
        enabled = true,
        cmdline = true,
        tabout = "<Tab>",
        back_tabout = "<S-Tab>",
      },
      highlights = {
        enabled = true,
        cmdline = true,
        groups = {
          "BlinkPairsOrange",
          "BlinkPairsPurple",
          "BlinkPairsBlue",
        },
        unmatched_group = "BlinkPairsUnmatched",
        matchparen = {
          enabled = true,
          cmdline = false,
          include_surrounding = false,
          group = "BlinkPairsMatchParen",
          priority = 250,
        },
      },
    })
  end,
}
