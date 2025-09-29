-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = " y" })
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = " y$" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d', { desc = " d" })
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { desc = " p" })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- General Keymaps
vim.keymap.set({ "n", "v", "x" }, "<leader>w", ":write<CR>", { desc = "Write file" })
vim.keymap.set({ "n", "v", "x" }, "<C-d>", "M<C-d>")
vim.keymap.set({ "n", "v", "x" }, "<C-u>", "M<C-u>")

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- nvim-notify
vim.keymap.set("n", "<leader>,", function()
  require("notify").dismiss({ silent = true, pending = false })
end, { desc = "Dismiss most recent notification" })
vim.keymap.set("n", "<leader><", function()
  require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all notifications" })

-- Options
local o = vim.o

o.signcolumn = "yes"

o.winborder = "rounded"

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

o.wrap = false

o.number = true
o.relativenumber = true

o.autowriteall = true

o.undofile = true

o.list = true
