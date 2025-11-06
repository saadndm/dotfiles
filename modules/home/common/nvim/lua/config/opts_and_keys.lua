-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = " y" })
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = " y$" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d', { desc = " d" })
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { desc = " p" })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- Code
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true })

-- General Keymaps
vim.keymap.set({ "n", "v", "x" }, "<leader>w", ":write<CR>", { desc = "Write file" })
vim.keymap.set({ "n", "v", "x" }, "<C-d>", "M<C-d>")
vim.keymap.set({ "n", "v", "x" }, "<C-u>", "M<C-u>")

-- undotree
vim.cmd("packadd! nvim.undotree")
vim.keymap.set("n", "<leader>u", vim.cmd.Undotree, { desc = "Undotree" })

-- scooter
local scooter_term = nil

-- Called by scooter to open the selected file at the correct line from the scooter search list
_G.EditLineFromScooter = function(file_path, line)
  if scooter_term and scooter_term:buf_valid() then
    scooter_term:hide()
  end

  local current_path = vim.fn.expand("%:p")
  local target_path = vim.fn.fnamemodify(file_path, ":p")

  if current_path ~= target_path then
    vim.cmd.edit(vim.fn.fnameescape(file_path))
  end

  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

local function is_terminal_running(term)
  if not term or not term:buf_valid() then
    return false
  end
  local channel = vim.fn.getbufvar(term.buf, "terminal_job_id")
  return channel and vim.fn.jobwait({ channel }, 0)[1] == -1
end

local function open_scooter()
  if is_terminal_running(scooter_term) then
    scooter_term:toggle()
  else
    scooter_term = require("snacks").terminal.open("scooter", {
      win = {
        position = "float",
        style = {
          border = "rounded"
        }
      },
    })
  end
end

local function open_scooter_with_text(search_text)
  if scooter_term and scooter_term:buf_valid() then
    scooter_term:close()
  end

  local escaped_text = vim.fn.shellescape(search_text:gsub("\r?\n", " "))
  scooter_term = require("snacks").terminal.open("scooter --fixed-strings --search-text " .. escaped_text, {
    win = { position = "float" },
  })
end

vim.keymap.set("n", "<leader>ss", open_scooter, { desc = "Open scooter" })
vim.keymap.set("v", "<leader>ss",
  function()
    local selection = vim.fn.getreg('"')
    vim.cmd('normal! "ay')
    open_scooter_with_text(vim.fn.getreg("a"))
    vim.fn.setreg('"', selection)
  end,
  { desc = "Search selected text in scooter" })

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
