require("lze").load {
  {
    "conform.nvim",
    event = "BufWritePre",
    after = function ()
      require("conform").setup({
        formatters = {
          biome = { command = vim.fn.exepath("biome") },
          injected = { options = { ignore_errors = true } },
        },
        formatters_by_ft = {
          nix = { "nixfmt" },
          go = { "gofmt" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          sh = { "shfmt" },
          typst = { "typstyle" },
          json = { "biome" },
          javascript = { "biome" },
          typescript = { "biome" },
          javascriptreact = { "biome" },
          typescriptreact = { "biome" },
          jsonc = { "biome" },
          css = { "biome" },
          haskell = { "ormolu" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
