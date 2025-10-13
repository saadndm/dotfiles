vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

require("flash").setup({
  modes = {
    search = {
      enabled = true
    }
  },
  search = {
    exclude = {
      "notify",
      "cmp_menu",
      "noice",
      "flash_prompt",
      "blink-cmp-menu",
      function(win)
        -- exclude non-focusable windows
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
  }
})
