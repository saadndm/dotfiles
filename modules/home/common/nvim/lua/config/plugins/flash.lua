vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

require("flash").setup({
  modes = {
    search = {
      enabled = true
    }
  }
})
