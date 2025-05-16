return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          auto_insert = false,
        },
      },
    },
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
  },
}
