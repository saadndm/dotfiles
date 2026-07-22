local now_if_args, later = Config.now_if_args, Config.later

-- Icon provider. Usually no need to use manually. It is used by plugins like
-- 'mini.pick', 'mini.files', 'mini.statusline', and others.
require("mini.icons").setup()

-- Tabline. Sets `:h 'tabline'` to show all listed buffers in a line at the top.
-- Buffers are ordered as they were created. Navigate with `<Leader>[` and `<Leader>]`.
require("mini.tabline").setup({
  tabpage_section = "right",
})

-- Miscellaneous small but useful functions.
now_if_args(function ()
  -- Makes `:h MiniMisc.put()` and `:h MiniMisc.put_text()` public
  require("mini.misc").setup()

  -- Restore latest cursor position on file open
  MiniMisc.setup_restore_cursor()
end)

-- Extra 'mini.nvim' functionality.
later(function ()
  require("mini.extra").setup()
end)

-- Extend and create a/i textobjects, like `:h a(`, `:h a'`, and more).
-- Contains not only `a` and `i` type of textobjects, but also their "next" and
-- "last" variants that will explicitly search for textobjects after and before
-- cursor.
later(function ()
  require("mini.ai").setup({
    search_method = "cover",
  })
end)

-- Go forward/backward with square brackets. Implements consistent sets of mappings
-- for selected targets (like buffers, diagnostic, quickfix list entries, etc.).
later(function ()
  require("mini.bracketed").setup({
    diagnostic = { options = { float = false } },
  })
end)

-- Remove buffers. Opened files occupy space in tabline and buffer picker.
-- When not needed, they can be removed.
later(function ()
  require("mini.bufremove").setup()
end)

-- Show next key clues in a bottom right window. Requires explicit opt-in for
-- keys that act as clue trigger. Example usage:
later(function ()
  local miniclue = require("mini.clue")
  -- stylua: ignore
  miniclue.setup({
    -- Define which clues to show. By default shows only clues for custom mappings
    -- (uses `desc` field from the mapping; takes precedence over custom clue).
    clues = {
      -- This is defined in 'keymaps.lua' with Leader group descriptions
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      -- This creates a submode for window resize mappings. Try the following:
      -- - Press `<C-w>s` to make a window split.
      -- - Press `<C-w>+` to increase height. Clue window still shows clues as if
      --   `<C-w>` is pressed again. Keep pressing just `+` to increase height.
      --   Try pressing `-` to decrease height.
      -- - Stop submode either by `<Esc>` or by any key that is not in submode.
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = { "n", "x" }, keys = "<Leader>" },  -- Leader triggers
      { mode = { "n", "x" }, keys = "[" },         -- mini.bracketed
      { mode = { "n", "x" }, keys = "]" },
      { mode = "i", keys = "<C-x>" },              -- Built-in completion
      { mode = { "n", "x" }, keys = "g" },         -- `g` key
      { mode = { "n", "x" }, keys = "'" },         -- Marks
      { mode = { "n", "x" }, keys = "`" },
      { mode = { "n", "x" }, keys = '"' },         -- Registers
      { mode = { "i", "c" }, keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" },              -- Window commands
      { mode = { "n", "x" }, keys = "s" },         -- `s` key (mini.surround, etc.)
      { mode = { "n", "x" }, keys = "z" },         -- `z` key
    },
  })
end)

-- Command line tweaks. Improves command line editing with:
-- - Autocorrection of words as-you-type. Like `:W`->`:w`, `:lau`->`:lua`, etc.
-- - Autopeek command range (like line number at the start) as-you-type.
later(function ()
  require("mini.cmdline").setup({
    autocomplete = {
      enable = false,
    },
  })
end)

-- Customizable user input. Improves how Neovim and plugins ask for input.
-- By default shows a floating window with the input prompt as title. Window
-- position depends on the input scope: at cursor, window or editor bottom left.
--
-- When asked for input:
-- - Type it. Note: this is not a regular Insert mode, but rather a customizable
--   and comprehensive Command-line mode emulation (it allows returning a value).
-- - Press `<Tab>` to show completion, `<C-p>` - previous history entry.
-- - Press `<CR>` to accept or `<Esc>` to cancel.
later(function ()
  require("mini.input").setup()
end)

-- Jump to next/previous single character. It implements "smarter `fFtT` keys"
-- (see `:h f`) that work across multiple lines, start "jumping mode", and
-- highlight all target matches.
later(function ()
  require("mini.jump").setup()
end)

-- Move any selection in any direction.
later(function ()
  require("mini.move").setup()
end)

-- Text edit operators. All operators have mappings for:
-- - Regular operator (waits for motion/textobject to use)
-- - Current line action (repeat second character of operator to activate)
-- - Act on visual selection (type operator in Visual mode)
--
-- Example usage:
-- - `griw` - replace (`gr`) *i*inside *w*ord
-- - `gmm` - multiple/duplicate (`gm`) current line (extra `m`)
-- - `vipgs` - *v*isually select *i*nside *p*aragraph and sort it (`gs`)
-- - `gxiww.` - exchange (`gx`) *i*nside *w*ord with next word (`w` to navigate
--   to it and `.` to repeat exchange operator)
-- - `g==` - execute current line as Lua code and replace with its output.
--   For example, typing `g==` over line `vim.lsp.get_clients()` shows
--   information about all available LSP clients.
--
-- See also:
-- - `:h MiniOperators-mappings` - overview of how mappings are created
-- - `:h MiniOperators-overview` - overview of present operators
later(function ()
  require("mini.operators").setup()

  -- Create mappings for swapping adjacent arguments. Notes:
  -- - Relies on `a` argument textobject from 'mini.ai'.
  -- - It is not 100% reliable, but mostly works.
  -- - It overrides `:h (` and `:h )`.
  -- Explanation: `gx`-`ia`-`gx`-`ila` <=> exchange current and last argument
  -- Usage: when on `a` in `(aa, bb)` press `)` followed by `(`.
  vim.keymap.set("n", "(", "gxiagxila", { remap = true, desc = "Swap arg left" })
  vim.keymap.set("n", ")", "gxiagxina", { remap = true, desc = "Swap arg right" })

  -- Create mappings for replacing from clipboard
  vim.keymap.set({ "n", "x" }, "gR", '"+gr', { remap = true, desc = " Replace" })
  vim.keymap.set("n", "gRr", '"+grr', { remap = true, desc = " Replace line" })
end)

-- Pick anything with single window layout and fast matching. This is one of
-- the main usability improvements as it powers a lot of "find things quickly"
-- workflows. How to use a picker:
-- - Start picker, usually with `:Pick <picker-name>` command. Like `:Pick files`.
--   It shows a single window in the bottom left corner filled with possible items
--   to choose from. Current item has special full line highlighting.
--   At the top there is a current query used to filter+sort items.
-- - Type characters (appear at top) to narrow down items. There is fuzzy matching:
--   characters may not match one-by-one, but they should be in correct order.
-- - Navigate down/up with `<C-n>`/`<C-p>`.
-- - Press `<Tab>` to show item's preview. `<Tab>` again goes back to items.
-- - Press `<S-Tab>` to show picker's info. `<S-Tab>` again goes back to items.
-- - Press `<CR>` to choose an item. The exact action depends on the picker: `files`
--   picker opens a selected file, `help` picker opens help page on selected tag.
--   To close picker without choosing an item, press `<Esc>`.
later(function ()
  require("mini.pick").setup()

  vim.keymap.set("n", "<leader>ft", function ()
    MiniPick.builtin.grep({
      pattern = [[\b(TODO|FIX|FIXME|BUG|HACK|WARN|PERF|NOTE|TEST):]],
      method = "regex",
    })
  end, { desc = "Todo comments" }
  )
end)

-- Surround actions: add/delete/replace/find/highlight. Working with surroundings
-- is surprisingly common: surround word with quotes, replace `)` with `]`, etc.
-- This module comes with many built-in surroundings, each identified by a single
-- character. It searches only for surrounding that covers cursor and comes with
-- a special "next" / "last" versions of actions to search forward or backward
-- (just like 'mini.ai'). All text editing actions are dot-repeatable (see `:h .`).
later(function ()
  require("mini.surround").setup()
end)

-- Highlight and remove trailspace. Temporarily stops highlighting in Insert mode
-- to reduce noise when typing.
later(function ()
  require("mini.trailspace").setup()
end)

-- Plugin development
later(function ()
  require("mini.test").setup()
end)
