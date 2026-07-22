local o = vim.o

-- General ====================================================================
vim.g.mapleader = " "  -- Use `<Space>` as <Leader> key

o.mouse = "a"            -- Enable mouse
o.switchbuf = "useopen"  -- Use already opened buffers when switching
o.undofile = true        -- Enable persistent undo

o.shada = "'100,<50,s10,:1000,/100,@100,h"  -- Limit ShaDa file (for startup)
vim.loader.enable()  -- Experimental Lua module loader (for startup)

o.backup = false  -- Don't store backup while overwriting the file
o.writebackup = false  -- Don't store backup while overwriting the file

-- Disable unused plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_nvim_dir_plugin = 1
vim.g.loaded_remote_plugins = 1

-- UI =========================================================================
o.breakindent = true          -- Indent wrapped lines to match line start
o.breakindentopt = "list:-1"  -- Add padding for lists (if 'wrap' is set)
o.cmdheight = 0               -- Disable command-line unless it is being used
o.colorcolumn = "+1"          -- Draw column on the right of maximum width
o.linebreak = true            -- Wrap lines at 'breakat' (if 'wrap' is set)
o.list = true                 -- Show helpful text indicators
o.number = true               -- Show line numbers
o.pumborder = "rounded"       -- Use border in popup menu
o.pumheight = 10              -- Make popup menu smaller
o.pummaxwidth = 100           -- Make popup menu not too wide
o.relativenumber = true       -- Show relative line numbers
o.ruler = false               -- Don't show cursor coordinates
o.shortmess = "CFOSWacou"     -- Disable some built-in completion messages
o.showmode = false            -- Don't show mode in command line
o.signcolumn = "yes"          -- Always show signcolumn (less flicker)
o.splitbelow = true           -- Horizontal splits will be below
o.splitkeep = "screen"        -- Reduce scroll during window split
o.splitright = true           -- Vertical splits will be to the right
o.winborder = "rounded"       -- Use border in floating windows
o.wrap = false                -- Don't visually wrap lines (toggle with \w)

-- Special UI symbols
o.fillchars = "eob: ,fold:╌,diff:╱"
o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> "

-- Editing ====================================================================
o.expandtab = true       -- Convert tabs to spaces
o.ignorecase = true      -- Ignore case during search
o.inccommand = "split"   -- Preview substitutions live in a split
o.shiftwidth = 2         -- Use this number of spaces for indentation
o.smartcase = true       -- Respect case if search pattern has upper case
o.smartindent = true     -- Make indenting smart
o.tabstop = 2            -- Show tab as this number of spaces
o.virtualedit = "block"  -- Allow going past end of line in blockwise mode

-- Autocommands ===============================================================

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local f = function ()
  vim.cmd("setlocal formatoptions-=c formatoptions-=o")
end
Config.new_autocmd("FileType", nil, f, "Proper 'formatoptions'")

-- Highlight yanked and put text
f = function ()
  vim.hl.hl_op()
end
Config.new_autocmd({ "TextYankPost", "TextPutPost" }, nil, f, "Highlight yanked and put text")

-- Diagnostics ================================================================

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
-- Use `later()` so that `vim.diagnostic` is only sourced after startup, not
-- while building the options table below.
Config.later(function ()
  vim.diagnostic.config({
    -- Sort diagnostics by severity
    severity_sort = true,

    -- Show all diagnostics as underline (for their messages type `<Leader>lf`)
    underline = { severity = { min = "HINT", max = "ERROR" } },

    -- Show the source of the diagnostic
    float = { source = true },

    signs = {
      -- Show signs on top of any other sign, but only for warnings and errors
      priority = 9999,
      severity = { min = "HINT", max = "ERROR" },

      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "󰌵",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        [vim.diagnostic.severity.WARN] = "WarningMsg",
      },
    },
  })
end)
