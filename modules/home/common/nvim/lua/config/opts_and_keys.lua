-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.conceallevel = 2
vim.o.concealcursor = "nvic"

-- Incremental selection
local map_lsp_selection = function (lhs, desc)
  local step = vim.startswith(desc, "Increase") and 1 or -1
  local rhs = function ()
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
vim.api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
  callback = function ()
    vim.hl.hl_op()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- General Keymaps
vim.keymap.set({ "n", "v", "x" }, "<leader>w", function ()
  vim.cmd("silent write")
end, { desc = "Write file" }
)
vim.keymap.set({ "n", "v", "x" }, "<leader>c", ":bd<CR>")
vim.keymap.set("n", "<leader>[", function ()
  vim.cmd("bprevious")
end, { desc = "Previous buffer" }
)
vim.keymap.set("n", "<leader>]", function ()
  vim.cmd("bnext")
end, { desc = "Next buffer" }
)

-- Center scrolling
vim.keymap.set({ "n", "v", "x" }, "<C-d>", "M<C-d>")
vim.keymap.set({ "n", "v", "x" }, "<C-u>", "M<C-u>")

-- undotree
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", function ()
  require("undotree").open({
    command = "botright " .. math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
  })
end, { desc = "Undotree" }
)

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

o.shortmess = o.shortmess .. "u"

o.report = 40

-- ui2
o.cmdheight = 0
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      default = "msg",
      emsg = "msg",
      echo = "cmd",
      echoerr = "msg",
      list_cmd = "msg",
      lua_error = "pager",
      progress = "pager",
      rpc_error = "pager",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      verbose = "pager",
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

vim.keymap.set("n", "<leader>,", function ()
  require("vim._core.ui2.messages").msg_clear()
end, { desc = "Clear notifications" }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "msg",
  callback = function ()
    local ui2 = require("vim._core.ui2")
    local win = ui2.wins and ui2.wins.msg

    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_option_value(
        "winhighlight", "Normal:NormalFloat,FloatBorder:FloatBorder", { scope = "local", win = win }
      )
      vim.api.nvim_set_option_value("wrap", true, { scope = "local", win = win })
      vim.api.nvim_set_option_value("linebreak", true, { scope = "local", win = win })
    end
  end,
})

local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos

local function msg_width(buf, max_width)
  local width = 1

  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  return math.min(width, max_width)
end

msgs.set_pos = function (tgt)
  orig_set_pos(tgt)

  local win = ui2.wins and ui2.wins.msg
  if (tgt == "msg" or tgt == nil) and win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      relative = "editor",
      anchor = "NE",
      row = 1,
      col = o.columns - 1,
      width = msg_width(vim.api.nvim_win_get_buf(win), math.floor(o.columns * 0.5)),
      border = "rounded",
    })
  end
end
