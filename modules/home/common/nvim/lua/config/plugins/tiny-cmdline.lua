return {
  "tiny-cmdline.nvim",
  lazy = false,
  after = function()
    require("tiny-cmdline").setup({
      on_reposition = require("tiny-cmdline").adapters.blink,
    })
  end,
}
