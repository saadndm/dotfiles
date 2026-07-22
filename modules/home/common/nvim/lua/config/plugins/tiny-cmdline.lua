vim.cmd.packadd("tiny-cmdline.nvim")

require("tiny-cmdline").setup({
  on_reposition = require("tiny-cmdline").adapters.blink,
  title = {
    enabled = true,
  },
})
