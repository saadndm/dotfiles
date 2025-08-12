vim.keymap.set("n", "<leader>/", function()
  require("fzf-lua").live_grep_native({
    cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  })
end, { desc = "Live Grep from Git Root" })

vim.keymap.set("n", "<leader>?", function()
  require("fzf-lua").helptags({
    prompt = "Help> ", -- custom prompt
    winopts = { height = 0.85, width = 0.80, preview = { default = "builtin" } },
  })
end, { desc = "Search Neovim help" })

require("fzf-lua").setup({
  winopts = { preview = { default = "bat" } },
})
