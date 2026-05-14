return {
  "nvim-jump",
  keys = "s",
  before = function ()
    vim.keymap.set({ "n", "x", "o" }, "s", function ()
      require("jump").start()
    end)
  end,
  after = function ()
    require("jump").setup({
      label = "MiniJump2dSpotUnique"
    })
  end
}
