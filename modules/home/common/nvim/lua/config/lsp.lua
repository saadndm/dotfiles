vim.lsp.enable({
  "emmylua_ls",
  "nixd",
  "gopls",
  "basedpyright",
  "tsgo",
  "hyprls",
  "ruff",
  "tinymist"
})

vim.diagnostic.config({
  virtual_lines = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
