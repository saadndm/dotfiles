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

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params
    .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

require("snacks").setup({
  bigfile = { enabled = true },
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
      input = {
        keys = {
          ["<a-c>"] = {
            "toggle_cwd",
            mode = { "n", "i" },
          },
        },
      },
    },
    actions = {
      toggle_cwd = function(p)
        local root = Snacks.git.get_root()
        local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
        local fff_state = require("config.plugins.fff-snacks").state
        local current = fff_state.current_dir or p:cwd()

        p:set_cwd(current == root and cwd or root)
        p:find()
      end,
    },
  },
  image = { enabled = true },
  quickfile = { enabled = true },
  terminal = { enabled = false }
})
