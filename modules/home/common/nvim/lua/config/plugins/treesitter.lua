vim.cmd.packadd("nvim-treesitter")
vim.cmd.packadd("nvim-treesitter-context")

local treesitter = require("nvim-treesitter")

local function treesitter_try_attach(buf, language)
  -- Check if parser exists and load it
  if not vim.api.nvim_buf_is_valid(buf) or not vim.treesitter.language.add(language) then
    return false
  end

  -- Enables syntax highlighting and other Tree-sitter features
  vim.treesitter.start(buf, language)

  -- Enables Tree-sitter based folds
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[win].foldmethod = "expr"
    vim.wo[win].foldlevel = 99
  end

  -- Enables Tree-sitter based indentation
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  return true
end

local installable_parsers = treesitter.get_available()
vim.api.nvim_create_autocmd("FileType", {
  callback = function (args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    if not treesitter_try_attach(buf, language) then
      if vim.tbl_contains(installable_parsers, language) then
        -- Not already installed, so try to install them via nvim-treesitter if possible
        treesitter.install(language):await(function ()
          treesitter_try_attach(buf, language)
        end)
      end
    end
  end,
})

require("treesitter-context").setup { max_lines = 3, mode = "topline" }
