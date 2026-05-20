return {
  {
    "markview.nvim",
    ft = { "markdown", "quarto", "rmd", "typst" },
    after = function (plugin)
      require("markview").setup({
        preview = {
          debounce = 1,
          modes = { "n", "i", "v", "c" },
          hybrid_modes = { "n", "i", "v", "c" },
          callbacks = {
            on_enable = function (_, win)
              vim.wo[win].conceallevel = 3
              vim.wo[win].concealcursor = "nvic"
            end,
            on_mode_change = function (_, win)
              vim.wo[win].conceallevel = 3
              vim.wo[win].concealcursor = "nvic"
            end,
            on_hybrid_enable = function (_, win)
              vim.wo[win].conceallevel = 3
              vim.wo[win].concealcursor = "nvic"
            end,
          },
        },
        typst = {
          math_blocks = { enable = false },
          math_spans = { enable = false },
          symbols = { enable = false },
          code_blocks = { enable = false },
          superscripts = { enable = false },
          subscripts = { enable = false },
        },
        latex = {
          blocks = { enable = false },
          inlines = { enable = false },
          symbols = { enable = false },
          superscripts = { enable = false },
          subscripts = { enable = false },
          commands = { enable = false },
          fonts = { enable = false },
        },
      })
    end,
  },
}
