return {
  {
    "tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    after = function(plugin)
      require("tiny-inline-diagnostic").setup({
        hi = {
          background = "None",
        },
        options = {
          override_open_float = true,
        }
      })
    end
  }
}
