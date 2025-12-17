vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

return {
  {
    "trouble.nvim",
    for_cat = "general.trouble",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("trouble").setup()
    end
  }
}
