vim.keymap.set("n", "<leader>tp", "<cmd>TypstPreviewToggle<cr>", { desc = "Toggle Typst Preview" })
vim.keymap.set("n", "<leader>ts", "<cmd>TypstPreviewStop<cr>", { desc = "Stop Typst Preview" })

return {
  {
    "typst-preview.nvim",
    event = "DeferredUIEnter",
    ft = "typst",
    after = function ()
      require("typst-preview").setup()
    end
  }
}
