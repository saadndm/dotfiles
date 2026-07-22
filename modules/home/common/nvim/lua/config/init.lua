Config.now(function ()
  require("config.options")
  require("config.keymaps")
  require("config.plugins")
end)

Config.now_if_args(function ()
  require("config.lsp")
end)

Config.later(function ()
  require("config.ui2")
end)

-- Auto format on save
Config.new_autocmd("BufWritePre", nil, function ()
  vim.lsp.buf.format()
end)
