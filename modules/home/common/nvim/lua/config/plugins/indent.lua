vim.cmd.packadd("blink.indent")

require("blink.indent").setup({
  scope = {
    highlights = {
      "BlinkIndentOrange",
      "BlinkIndentViolet",
      "BlinkIndentBlue",
      "BlinkIndentRed",
      "BlinkIndentYellow",
    },
  },
})
