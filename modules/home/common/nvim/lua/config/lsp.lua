vim.lsp.enable({
  "emmylua_ls",
  "nixd",
  "gopls",
  "ty",
  "tsgo",
  "hyprls",
  "ruff",
  "tinymist",
  "jsonls",
  "bashls",
  "biome",
  "clangd",
  "hls",
})

vim.lsp.config("emmylua_ls", {
  settings = {
    Lua = {
      runtime = {
        requirePattern = {
          "?.lua",
          "?/init.lua",
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
    },
  },
})

vim.diagnostic.config({
  virtual_lines = false,
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
