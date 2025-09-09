require("lze").load {
  {
    "conform.nvim",
    for_cat = "format",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("conform").setup({
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
        formatters_by_ft = {
          nix = { "nixfmt" },
          go = { "gofmt" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          bash = { "shfmt" },
          typst = { "typstyle" }
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  }
}
