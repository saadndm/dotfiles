-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.conceallevel = 2
vim.o.concealcursor = "nvic"

-- Incremental selection
local map_lsp_selection = function(lhs, desc)
  local step = vim.startswith(desc, "Increase") and 1 or -1
  local rhs = function()
    if vim.fn.mode() == "n" then
      vim.cmd.normal({ args = { "v" }, bang = true })
    end
    vim.lsp.buf.selection_range(step * vim.v.count1)
  end
  vim.keymap.set({ "n", "x" }, lhs, rhs, { desc = desc })
end
map_lsp_selection("<A-o>", "Increase selection")
map_lsp_selection("<A-i>", "Decrease selection")

-- Emacs keybinds
vim.keymap.set({ "i", "c" }, "<C-a>", "<C-o>^")
vim.keymap.set({ "i", "c" }, "<C-e>", "<C-o>$")
vim.keymap.set({ "i", "c" }, "<M-d>", "<C-o>dw")

-- Clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>Y", '"+y$', { desc = " y" })
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = " y$" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d', { desc = " d" })
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { desc = " p" })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- General Keymaps
vim.keymap.set({ "n", "v", "x" }, "<leader>w", function() vim.cmd.w() end, { desc = "Write file" })
vim.keymap.set({ "n", "v", "x" }, "<leader>bd", ":bd<CR>")

-- Center scrolling
vim.keymap.set({ "n", "v", "x" }, "<C-d>", "M<C-d>")
vim.keymap.set({ "n", "v", "x" }, "<C-u>", "M<C-u>")

-- undotree
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", function()
  require("undotree").open({
    command = "botright " .. math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
  })
end, { desc = "Undotree" })

-- Options
vim.loader.enable()

local o = vim.o

o.signcolumn = "yes"

o.winborder = "rounded"

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

o.wrap = false

o.number = true
o.relativenumber = true

o.autowriteall = true

o.undofile = true

o.list = true

o.spell = true
o.spelllang = "en"

o.ignorecase = true

-- ui2
o.cmdheight = 0
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "msg",
  callback = function()
    local ui2 = require("vim._core.ui2")
    local win = ui2.wins and ui2.wins.msg
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_option_value(
        "winhighlight",
        "Normal:NormalFloat,FloatBorder:FloatBorder",
        { scope = "local", win = win }
      )
    end
  end,
})

local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
  orig_set_pos(tgt)
  local win = ui2.wins and ui2.wins.msg
  if (tgt == "msg" or tgt == nil) and win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      relative = "editor",
      anchor = "NE",
      row = 1,
      col = vim.o.columns - 1,
      border = "rounded",
    })
  end
end

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or "done" } }, false, {
      id = "lsp." .. ev.data.client_id,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
    })
  end,
})
