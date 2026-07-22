vim.keymap.set("n", "<leader>tp", "<cmd>TypstPreviewToggle<cr>", { desc = "Toggle Typst Preview" })

vim.cmd.packadd("typst-preview.nvim")
require("typst-preview").setup()
