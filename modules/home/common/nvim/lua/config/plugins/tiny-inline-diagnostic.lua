return {
  {
    "tiny-inline-diagnostic.nvim",
    for_cat = "general.tiny-inline-diagnostic",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("tiny-inline-diagnostic").setup()
    end
  }
}
