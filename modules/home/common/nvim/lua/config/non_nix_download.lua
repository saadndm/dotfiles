local function gh(repo)
  return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function (ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= "install" and kind ~= "update" then return end

    if name == "fff.nvim" then
      vim.schedule(function ()
        vim.cmd.packadd("fff.nvim")

        local ok, fff = pcall(require, "fff.download")
        if ok then
          fff.download_or_build_binary()
        end
      end)
    end
  end,
})

vim.pack.add({
  { src = gh("BirdeeHub/lze"), load = true },
  { src = gh("BirdeeHub/lzextras"), load = true },
  gh("MunifTanjim/nui.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("stevearc/oil.nvim"),
  gh("b0o/schemastore.nvim"),
  gh("dmtrKovalenko/fff.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("wakatime/vim-wakatime"),
  gh("folke/snacks.nvim"),
  { src = gh("saghen/blink.pairs"), version = vim.version.range("*") },
  { src = gh("saghen/blink.indent"), version = vim.version.range("*") },
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-context"),
  gh("catppuccin/nvim"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
  gh("xzbdmw/colorful-menu.nvim"),
  gh("nvim-mini/mini.nvim"),
  gh("folke/noice.nvim"),
  gh("chomosuke/typst-preview.nvim"),
  gh("folke/flash.nvim"),
  gh("folke/trouble.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("rachartier/tiny-inline-diagnostic.nvim"),
  gh("kdheepak/lazygit.nvim"),
  gh("stevearc/conform.nvim"),
  gh("mfussenegger/nvim-lint"),
})
