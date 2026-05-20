return {
  "snacks.nvim",
  event = "DeferredUIEnter",
  after = function ()
    vim.keymap.set("n", "<leader>?", function ()
      Snacks.picker.help()
    end, { desc = "Help Pages" }
    )

    vim.keymap.set("n", "<leader>gb", function ()
      Snacks.picker.git_log_line()
    end, { desc = "Git Blame Line" }
    )
    vim.keymap.set({ "n", "x" }, "<leader>gB", function ()
      Snacks.gitbrowse()
    end, { desc = "Git Browse (open)" }
    )

    require("snacks").setup({
      bigfile = {
        enabled = true,
        size = 0.5 * 1024 * 1024,
      },
      picker = {
        win = {
          list = {
            keys = {
              ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<a-c>"] = { "toggle_search_cwd", mode = { "i", "n" } },
            },
          },
          input = {
            keys = {
              ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<a-c>"] = { "toggle_search_cwd", mode = { "i", "n" } },
            },
          },
        },
      },
      image = {
        enabled = true,
        doc = {
          float = true,
          inline = true,
        },
        math = { enabled = true },
      },
      scroll = { enabled = true },
    })

    require("config.plugins.scooter")
  end,
}
