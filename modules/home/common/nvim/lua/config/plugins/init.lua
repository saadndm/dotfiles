if nixCats("themer") then
  require("config.plugins.catppuccin")
end

if nixCats("general.extra") then
  require("config.plugins.oil")
  require("config.plugins.fff")
  require("config.plugins.snacks")
  require("config.plugins.pairs")
end

require("lze").load {
  { import = "config.plugins.treesitter" },
  { import = "config.plugins.completion" },
  { import = "config.plugins.mini" },
  { import = "config.plugins.noice" },
  { import = "config.plugins.typst-preview" },
  { import = "config.plugins.flash" },
  { import = "config.plugins.trouble" },
  { import = "config.plugins.todo-comments" },
  { import = "config.plugins.tiny-inline-diagnostic" }
}
