vim.opt.rtp:append("~/Projects/mathlive.nvim/")

require("mathlive").setup({
  color_hex = "#ffffff",
  preamble = [[
    #set math.mat(delim: "[")
    #set math.vec(delim: "[")
  ]],
})
