return {
  "oil.nvim",
  cmd = "Oil",
  keys = { "-", "<leader>-" },
  before = function()
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = "Open Parent Directory" })
    vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, desc = "Open nvim root directory" })
  end,
  after = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true
      },
      columns = {
        "icon",
        -- "permissions",
        "size",
        -- "mtime",
      },
    })
  end,
}
