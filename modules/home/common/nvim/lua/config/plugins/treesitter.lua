return {
  {
    "nvim-treesitter",
    lazy = false,
    after = function()
      local function start(buf)
        local language = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if language and vim.treesitter.language.add(language) then
          vim.treesitter.start(buf, language)
        end

        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args) start(args.buf) end,
      })

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype ~= "" then start(buf) end
      end
    end,
  },
  {
    "nvim-treesitter-context",
    lazy = false,
    after = function()
      require("treesitter-context").setup {
        max_lines = 3,
        mode = "topline",
      }
    end,
  },
}
