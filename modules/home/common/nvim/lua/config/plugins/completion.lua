vim.cmd.packadd("blink.cmp")
vim.cmd.packadd("colorful-menu.nvim")

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
          kind_icon = {
          text = function(ctx)
            if ctx.source_name ~= "Path" then
              return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
            end

            local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
            local mini_icon, _ = require("mini.icons").get(
              is_unknown_type and "os" or ctx.item.data.type,
              is_unknown_type and "" or ctx.label
            )

            return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
          end,

          highlight = function(ctx)
            if ctx.source_name ~= "Path" then return ctx.kind_hl end

            local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
            local mini_icon, mini_hl = require("mini.icons").get(
              is_unknown_type and "os" or ctx.item.data.type,
              is_unknown_type and "" or ctx.label
            )
            return mini_icon ~= nil and mini_hl or ctx.kind_hl
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
