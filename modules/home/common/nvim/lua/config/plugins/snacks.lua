vim.keymap.set("n", "<leader><", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss all notifications" })

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "LazyGit" })

vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.grep({ cwd = Snacks.git.get_root() })
end, { desc = "Grep (Git Root)" })

vim.keymap.set("n", "<leader>?", function()
  Snacks.picker.help()
end, { desc = "Help Pages" })


vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gh", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
vim.keymap.set({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })

require("snacks").setup({
  animate = { enabled = true },
  bigfile = {
    enabled = true,
    size = 0.5 * 1024 * 1024
  },
  notifier = { enabled = true },
  notifiy = { enabled = true },
  lazygit = {
    enabled = true,
    configure = false,
    win = {
      style = {
        border = "rounded",
      }
    }
  },
  picker = {
    win = {
      style = {
        border = "rounded",
        backdrop = 100,
      },
      list = {
        keys = {
          ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<a-c>"] = { "toggle_cwd", mode = { "i", "n" } },

        }
      },
      input = {
        keys = {
          ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<a-c>"] = { "toggle_cwd", mode = { "i", "n" } },
        },
      },
    },
    actions = {
      toggle_cwd = function(p)
        local root = Snacks.git.get_root()
        local cwd = vim.fs.normalize(vim.uv.cwd() or ".")
        local fff_state = require("config.plugins.fff-snacks").state
        local current = fff_state.current_dir or p:cwd()

        p:set_cwd(current == root and cwd or root)
        p:find()
      end,
    },
  },
  image = {
    enabled = true,
    doc = {
      float = true,
      inline = false,
    },
    math = { enabled = false }
  },
  quickfile = { enabled = true },
  scroll = { enabled = true },
  terminal = { enabled = false }
})
