vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("nvim-treesitter").setup {
  highlight = { enable = true, },
  indent = { enable = true, },
}

require("treesitter-context").setup {
  max_lines = 3,
  mode = "topline"
}
