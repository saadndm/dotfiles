Config.now(function ()
  require("config.plugins.catppuccin")
  require("config.plugins.statusline")
  require("config.plugins.mini")
end)

Config.now_if_args(function ()
  vim.cmd.packadd("faster.nvim")

  vim.cmd.packadd("nvim-lspconfig")

  require("config.plugins.pairs")
  require("config.plugins.indent")

  require("config.plugins.colorizer")

  require("config.plugins.treesitter")

  require("config.plugins.tiny-inline-diagnostic")

  require("config.plugins.nvim-jump")

  require("config.plugins.gitsigns")

  require("config.plugins.canola")
end)

Config.later(function ()
  require("config.plugins.fff")

  require("config.plugins.snacks")

  vim.cmd.packadd("grug-far.nvim")
  require("grug-far").setup()

  require("config.plugins.tiny-cmdline")

  require("config.plugins.diffview")
end)

Config.on_event("InsertEnter,CursorHold,CursorHoldI,BufWritePost", function ()
  vim.cmd.packadd("vim-wakatime")
end)

Config.on_event("InsertEnter,CmdlineEnter", function ()
  require("config.plugins.completion")
end)

Config.on_filetype("lua", function ()
  require("lazydev").setup()
end)

Config.on_filetype("typst", function ()
  require("config.plugins.typst-preview")
end)

Config.on_filetype("markdown", function ()
  require("config.plugins.obsidian")
end)

Config.on_filetype("typst,markdown", function ()
  require("config.plugins.mathlive")
  require("config.plugins.markview")
end)
