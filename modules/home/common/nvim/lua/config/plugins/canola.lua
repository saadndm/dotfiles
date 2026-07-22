vim.g.canola = { columns = { "icon", "size" }, confirm = "delete", hidden = { enabled = false } }

vim.cmd.packadd("canola.nvim")

vim.keymap.set("n", "-", "<cmd>Canola<CR>", { desc = "Open Parent Directory" })
