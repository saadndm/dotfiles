vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
return {
  {
    "flash.nvim",
    for_cat = "general.flash",

    event = "DeferredUIEnter",
    after = function(plugin)
      require("flash").setup()
    end
  }
}
