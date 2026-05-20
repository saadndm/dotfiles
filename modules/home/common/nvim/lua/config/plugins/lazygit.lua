return {
  "lazygit.nvim",
  cmd = { "LazyGit", "LazyGitFilterCurrentFile" },
  keys = {
    {
      "<leader>gg",
      function ()
        require("lazygit").lazygit()
      end,
      desc = "LazyGit",
    },
    {
      "<leader>gh",
      function ()
        require("lazygit").lazygitfiltercurrentfile()
      end,
      desc = "Git Current File History",
    },
  },
  after = function ()
    vim.api.nvim_set_hl(0, "LazyGitBorder", { link = "FloatBorder" })
  end,
}
