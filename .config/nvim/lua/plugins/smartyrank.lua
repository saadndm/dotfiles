return {
  "ibhagwan/smartyank.nvim",
  config = function()
    require("smartyank").setup({
      highlight = { enabled = false },
      clipboard = { enabled = true },
      validate_yank = true,
      osc52 = { enabled = true, ssh_only = true, silent = true },
    })
  end,
}
