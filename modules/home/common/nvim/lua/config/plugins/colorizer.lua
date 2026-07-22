vim.cmd.packadd("nvim-colorizer.lua")

require("colorizer").setup({
  options = {
    display = {
      mode = "virtualtext",
      virtualtext = {
        position = "before",
        char = "■",
      },
    },
  },
})
