vim.cmd.packadd("diffview-plus.nvim")

local function copy_hash()
  local view = require("diffview.lib").get_current_view()

  if view and view.panel:is_focused() then
    local item = view.panel:get_item_at_cursor()

    if item and item.commit and item.commit.hash then
      vim.fn.setreg("+", item.commit.hash)
      vim.notify(("Copied '%s' to the system clipboard."):format(item.commit.hash))
    end
  end
end

require("diffview").setup({
  keymaps = {
    file_history_panel = {
      { "n", "y", copy_hash },
    },
  },
  view = {
    cycle_layouts = {
      default = {
        "diff2_horizontal",
        "diff1_inline",
      },
    },
  },
})
