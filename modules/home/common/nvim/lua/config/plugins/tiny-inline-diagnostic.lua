return {
  {
    "tiny-inline-diagnostic.nvim",
    for_cat = "general.tiny-inline-diagnostic",
    event = "DeferredUIEnter",
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
