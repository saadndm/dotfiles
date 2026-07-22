local function gh(repo)
  return "https://github.com/" .. repo
end

Config.on_packchanged("nvim-treesitter", { "update" }, function ()
  vim.cmd.TSUpdate()
end, ":TSUpdate"
)

Config.on_packchanged("fff.nvim", { "install", "update" }, function ()
  require("fff.download").download_or_build_binary()
end, "Install FFF binary"
)

local startup = {
  gh("catppuccin/nvim"),
  gh("rachartier/tiny-inline-diagnostic.nvim"),
  gh("xzbdmw/colorful-menu.nvim"),
  gh("onsails/lspkind.nvim"),
  gh("b0o/schemastore.nvim"),
  {
    src = gh("bmrips/lazydev.nvim"),
    version = "0fd6a934c7271989c8cc91d8e5c8a078d8137c33",
  },
}

local plugins = {
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-context"),
  gh("neovim/nvim-lspconfig"),
  {
    src = gh("saghen/blink.cmp"),
    version = "v1",
  },
  gh("saghen/blink.indent"),
  gh("rachartier/tiny-cmdline.nvim"),
  gh("barrettruth/canola.nvim"),
  {
    src = gh("dmtrKovalenko/fff.nvim"),
    version = vim.version.range("*"),
  },
  gh("folke/snacks.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("dlyongemallo/diffview-plus.nvim"),
  gh("norcalli/nvim-colorizer.lua"),
  gh("pteroctopus/faster.nvim"),
  gh("MagicDuck/grug-far.nvim"),
  gh("wakatime/vim-wakatime"),
  gh("chomosuke/typst-preview.nvim"),
  gh("OXY2DEV/markview.nvim"),
  gh("obsidian-nvim/obsidian.nvim"),
}

vim.pack.add(startup)

vim.pack.add(plugins, {
  load = function () end,
})
