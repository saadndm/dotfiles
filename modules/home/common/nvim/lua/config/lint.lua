vim.api.nvim_create_user_command("LintInfo", function()
  local filetype = vim.bo.filetype
  local linters = require("lint").linters_by_ft[filetype]

  if linters then
    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
  else
    print("No linters configured for filetype: " .. filetype)
  end
end, {})

require("lze").load {
  {
    "nvim-lint",
    for_cat = "lint",
    event = "FileType",
    after = function(plugin)
      require("lint").linters_by_ft = {
        fish = { "fish" },
        go = { "golangcilint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
