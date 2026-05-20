return {
  {
    "mathlive.nvim",
    ft = { "typst", "markdown" },
    load = function (name)
      vim.opt.rtp:append("~/Documents/Projects/mathlive.nvim/")
    end,
    after = function ()
      require("mathlive").setup({
        color_hex = "#ffffff",
        preamble = [[
          #set math.mat(delim: "[")
          #set math.vec(delim: "[")
        ]],
      })
    end,
  },
}
