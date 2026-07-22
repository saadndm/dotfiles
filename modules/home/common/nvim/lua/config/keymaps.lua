local map = vim.keymap.set

-- General mappings ===========================================================

-- Copy/paste/delete with system clipboard
map({ "n", "x" }, "<leader>Y", '"+y$', { desc = " y$" })
map({ "n", "x" }, "<leader>y", '"+y', { desc = " y" })
map({ "n", "x" }, "<leader>d", '"+d', { desc = " d" })
map({ "n", "x" }, "<leader>D", '"+d$', { desc = " d$" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = " p" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = " P" })

-- Center scrolling
map({ "n", "x" }, "<C-d>", "M<C-d>")
map({ "n", "x" }, "<C-u>", "M<C-u>")

-- Clear search highlight
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })

-- Insert/command mode
map({ "i", "c" }, "<M-h>", "<Left>", { silent = false, desc = "Left" })
map({ "i", "c" }, "<M-l>", "<Right>", { silent = false, desc = "Right" })
map("i", "<M-k>", "<Up>", { desc = "Up" })
map("i", "<M-j>", "<Down>", { desc = "Down" })
map("i", "<M-w>", "<C-o>w", { desc = "Word forward" })
map("c", "<M-w>", "<C-Right>", { desc = "Word forward" })
map({ "i", "c" }, "<C-a>", "<Home>", { desc = "Go to start of line" })
map({ "i", "c" }, "<C-e>", "<End>", { desc = "Go to end of line" })

-- Re-select latest changed, put, or yanked text
map("n", "gV", '"g`[" . strpart(getregtype(), 0, 1) . "g`]"', {
  expr = true,
  replace_keycodes = false,
  desc = "Visually select changed text",
})

-- Move by visible lines. Notes:
-- - Don't map in Operator-pending mode because it severely changes behavior:
--   like `dj` on non-wrapped line will not delete it.
-- - Condition on `v:count == 0` to allow easier use of relative line numbers.
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Preserve search direction (https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n)
map("n", "n", "'Nn'[v:searchforward] . 'zv'", { expr = true, desc = "Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward] . 'zv'", { expr = true, desc = "Previous Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous Search Result" })

-- Use command-line history unless completion menu is active (https://github.com/mhinz/vim-galore#saner-command-line-history)
map("c", "<C-n>", [[wildmenumode() ? "\<C-n>" : "\<Down>"]], { expr = true, desc = "Next command history item" })
map("c", "<C-p>", [[wildmenumode() ? "\<C-p>" : "\<Up>"]], { expr = true, desc = "Previous command history item" })

-- Preserve visual selection after shifting indentation (https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards)
map("x", "<", "<gv", { desc = "Shift selection left" })
map("x", ">", ">gv", { desc = "Shift selection right" })

-- Add empty lines before and after cursor line supporting dot-repeat
local cache_empty_line
_G.put_empty_line = function (put_above)
  -- This has a typical workflow for enabling dot-repeat:
  -- - On first call it sets `operatorfunc`, caches data, and calls
  --   `operatorfunc` on current cursor position.
  -- - On second call it performs task: puts `v:count1` empty lines
  --   above/below current line.
  if type(put_above) == "boolean" then
    vim.o.operatorfunc = "v:lua.put_empty_line"
    cache_empty_line = { put_above = put_above }
    return "g@l"
  end

  if not cache_empty_line then return end
  local target_line = vim.fn.line(".") - (cache_empty_line.put_above and 1 or 0)
  vim.fn.append(target_line, vim.fn['repeat']({ "" }, vim.v.count1))
end
map("n", "gO", "v:lua.put_empty_line(v:true)", { expr = true, desc = "Put empty line above" })
map("n", "go", "v:lua.put_empty_line(v:false)", { expr = true, desc = "Put empty line below" })

-- Remap incremental selection ('v_an' and 'v_in') due to confliction with 'mini.ai'
_G.selection = function (target)
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    vim.treesitter.select(target, vim.v.count1)
  else
    local step = target == "parent" and 1 or -1
    vim.lsp.buf.selection_range(step * vim.v.count1)
  end
end
map({ "n", "x" }, "<A-o>", "<Cmd>lua _G.selection('parent')<CR>", { desc = "Increase selection" })
map({ "n", "x" }, "<A-i>", "<Cmd>lua _G.selection('child')<CR>", { desc = "Decrease selection" })

-- Window navigation
map("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
map("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
map("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
map("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })

-- Window resize (respecting `v:count`)
map("n", "<C-Left>", '"<Cmd>vertical resize -" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Decrease window width",
})
map("n", "<C-Down>", '"<Cmd>resize -" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Decrease window height",
})
map("n", "<C-Up>", '"<Cmd>resize +" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Increase window height",
})
map("n", "<C-Right>", '"<Cmd>vertical resize +" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Increase window width",
})

-- Git hunk navigation
map("n", "]g", function ()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    vim.cmd("Gitsigns nav_hunk next")
  end
end, { desc = "Next hunk" }
)
map("n", "[g", function ()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    vim.cmd("Gitsigns nav_hunk prev")
  end
end, { desc = "Previous hunk" }
)

-- Leader mappings ============================================================

-- Create a global table with information about Leader groups in certain modes.
-- This is used to provide 'mini.clue' with extra clues.
-- Add an entry if you create a new group.
Config.leader_group_clues = {
  { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
  { mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
  { mode = "n", keys = "<Leader>f", desc = "+Find" },
  { mode = "n", keys = "<Leader>g", desc = "+Git" },
  { mode = "n", keys = "<Leader>l", desc = "+Language" },
  { mode = "n", keys = "<Leader>m", desc = "+Map" },
  { mode = "n", keys = "<Leader>o", desc = "+Other" },
  { mode = "n", keys = "<Leader>s", desc = "+Session" },
  { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
  { mode = "n", keys = "<Leader>v", desc = "+Visits" },

  { mode = "x", keys = "<Leader>g", desc = "+Git" },
  { mode = "x", keys = "<Leader>l", desc = "+Language" },
}

-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map("n", "<Leader>w", "<Cmd>silent! write | redraw<CR>", { desc = "Save" })

-- Buffer
map("n", "<Leader><Tab>", "<Cmd>b#<CR>", { desc = "Alternate buffer" })
map("n", "<Leader>c", "<cmd>lua MiniBufremove.delete()<cr>", { desc = "Delete buffer" })
map("n", "<Leader>[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<Leader>]", "<Cmd>bnext<CR>", { desc = "Next buffer" })

-- Undo-tree
Config.later(function ()
  vim.cmd.packadd("nvim.undotree")
  _G.open_undotree = function ()
    require("undotree").open({
      command = "botright " .. math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
    })
  end
end)
map("n", "<Leader>u", "<Cmd>lua open_undotree()<CR>", { desc = "Undotree" })

-- Clear ui2 notifications
map({ "n", "x" }, "<Leader>,", "<Cmd>lua require('vim._core.ui2.messages').msg_clear()<CR>", {
  desc = "Clear notifications",
})

-- b is for 'Buffer'
local new_scratch_buffer = function ()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

map("n", "<Leader>bs", new_scratch_buffer, { desc = "Scratch" })

-- e is for 'Explore' and 'Edit'
local explore_quickfix = function ()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and "cclose" or "copen")
end
local explore_locations = function ()
  vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and "lclose" or "lopen")
end

map("n", "<Leader>en", "<Cmd>messages<CR>", { desc = "Notifications" })
map("n", "<Leader>eq", explore_quickfix, { desc = "Quickfix list" })
map("n", "<Leader>eQ", explore_locations, { desc = "Location list" })
map("n", "<Leader>et", "<Cmd>Pick todo<CR>", { desc = "Todo list" })

-- f is for 'Fuzzy Find'
--
-- All these use 'mini.pick'. See `:h MiniPick-overview` for an overview.
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

map("n", "<Leader>f/", '<Cmd>Pick history scope="/"<CR>', { desc = '"/" history' })
map("n", "<Leader>f:", '<Cmd>Pick history scope=":"<CR>', { desc = '":" history' })
map("n", "<Leader>fb", "<Cmd>Pick buffers<CR>", { desc = "Buffers" })
map("n", "<Leader>fd", '<Cmd>Pick diagnostic scope="all"<CR>', { desc = "Diagnostic workspace" })
map("n", "<Leader>fD", '<Cmd>Pick diagnostic scope="current"<CR>', { desc = "Diagnostic buffer" })
map("n", "<Leader>ff", "<Cmd>Pick resume<CR>", { desc = "Resume" })
map("n", "<Leader>fh", "<Cmd>Pick help<CR>", { desc = "Help tags" })
map({ "n", "x" }, "<Leader>fr", "<Cmd>GrugFarWithin<CR>", { desc = "Search and Replace" })
map("n", "<Leader>fR", '<Cmd>Pick lsp scope="references"<CR>', { desc = "References (LSP)" })
map("n", "<Leader>fs", pick_workspace_symbols_live, { desc = "Symbols workspace (live)" })
map("n", "<Leader>fS", '<Cmd>Pick lsp scope="document_symbol"<CR>', { desc = "Symbols document" })

-- g is for 'Git'
map("n", "<Leader>gb", "<Cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<Leader>gB", "<Cmd>.DiffviewFileHistory<CR>", { desc = "Current line history" })
map("x", "<Leader>gB", ":DiffviewFileHistory<CR>", { desc = "Selected lines history" })
map("n", "<Leader>gd", "<Cmd>DiffviewToggle<CR>", { desc = "Diff" })
map("n", "<Leader>gh", "<Cmd>DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<Leader>go", function ()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  vim.cmd(("DiffviewOpen --no-panel --selected-row=%d -- %%"):format(line))
end, { desc = "Diff buffer" }
)
map({ "n", "x" }, "<Leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map({ "n", "x" }, "<Leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage/unstage hunk" })

-- l is for 'Language'
--
-- NOTE: most LSP mappings represent a more structured way of replacing built-in
-- LSP mappings (like `:h gra` and others). This is needed because `gr` is mapped
-- by an "replace" operator in 'mini.operators' (which is more commonly used).
map("n", "<Leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Actions" })
map("n", "<Leader>lf", "<Cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostic float" })
map("n", "<Leader>li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Implementation" })
map("n", "<Leader>ll", "<Cmd>lua vim.lsp.codelens.run()<CR>", { desc = "Lens" })
map("n", "<Leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
map("n", "<Leader>lR", "<Cmd>lua vim.lsp.buf.references()<CR>", { desc = "References" })
map("n", "<Leader>ls", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Source definition" })
map("n", "<Leader>lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type definition" })
