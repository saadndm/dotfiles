return {
  {
    "colorful-menu.nvim",
    on_plugin = { "blink.cmp" },
  },
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function (_)
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          ["<C-u>"] = { "scroll_signature_up", "fallback" },
          ["<C-d>"] = { "scroll_signature_down", "fallback" },
          ["<S-u>"] = { "scroll_documentation_up", "fallback" },
          ["<S-d>"] = { "scroll_documentation_down", "fallback" },
        },
        cmdline = {
          completion = { menu = { auto_show = true } },
        },
        signature = {
          enabled = true,
        },
        completion = {
          menu = {
            draw = {
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                label = {
                  text = function (ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function (ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
          },
        },
        sources = {
          default = { "lazydev", "lsp", "buffer", "snippets", "path", "omni" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
        },
      })
    end,
  },
}
