return {
  {
    "obsidian.nvim",
    ft = "markdown",
    after = function (plugin)
      require("obsidian").setup({
        legacy_commands = false,
        workspaces = {
          {
            name = "personal",
            path = "~/Documents/Obsidian/Saad"
          }
        },
        frontmatter = {
          func = function (note)
            local out = {}
            if note.metadata then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end
            return out
          end
        }
      })
    end
  }
}
