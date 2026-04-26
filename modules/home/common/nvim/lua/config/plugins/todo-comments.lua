vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })

return {
  {
    "todo-comments.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("todo-comments").setup()
    end
  }
}
