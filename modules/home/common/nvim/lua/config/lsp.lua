vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
})

vim.lsp.enable({
  "emmylua_ls",
  "harper_ls",
  "nixd",
  "ruff",
  "ty",
  "tsgo",
  "oxfmt",
  "oxlint",
  "tinymist",
  "gopls",
  "clangd",
  "hls",
  "rust_analyzer",
  "jsonls",
  "bashls",
  "yamlls",
})
