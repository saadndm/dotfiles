if nixCats("themer") then
  require("config.plugins.catppuccin")
end

if nixCats("general.extra") then
  require("config.plugins.oil")
  require("config.plugins.fff")
  require("config.plugins.snacks")
  require("config.plugins.flash")
end

if nixCats("treesitter") then
  require("config.plugins.treesitter")
end

require("lze").load {
  { import = "config.plugins.completion" },
  { import = "config.plugins.mini" },
  { import = "config.plugins.noice" },
  { import = "config.plugins.git" },
  { import = "config.plugins.typst-preview" },
  { import = "config.plugins.ultimate-autopair" }
}
