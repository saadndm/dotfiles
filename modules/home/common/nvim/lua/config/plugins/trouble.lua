vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

return {
  {
    "trouble.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("trouble").setup()
    end
  }
}
