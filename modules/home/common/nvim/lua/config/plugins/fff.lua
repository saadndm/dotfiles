vim.cmd.packadd("fff.nvim")
local fff = require("fff")

local search_cwd = false
local search_root

local function get_root_markers()
  local res = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    local markers = client.config and client.config.root_markers
    if markers then
      vim.list_extend(res, markers)
    end
  end

  return res
end

local function get_search_root()
  local git_root = vim.fs.root(0, ".git")
  if git_root then return git_root end

  local root_markers = get_root_markers()
  local root = #root_markers > 0 and vim.fs.root(0, root_markers)

  return root or vim.fn.getcwd()
end

vim.keymap.set("n", "<leader><leader>", function ()
  search_root = get_search_root()
  search_cwd = false
  fff.find_files({ cwd = search_root })
end, { desc = "FFF" }
)

vim.keymap.set("n", "<leader>/", function ()
  search_root = get_search_root()
  search_cwd = false
  fff.live_grep({ cwd = search_root })
end, { desc = "FFF" }
)

local function change_picker_root(root)
  local picker_ui = require("fff.picker_ui.picker_ui")
  local file_picker = require("fff.file_picker")
  local rust = require("fff.rust")

  root = vim.fs.normalize(root)

  if not fff.change_indexing_directory(root) then
    return false
  end

  local function poll()
    if not picker_ui.state.active then return end

    local ok, health = pcall(rust.health_check, root)
    local picker = ok and health and health.file_picker

    if not picker or not picker.base_path or vim.fs.normalize(picker.base_path) ~= root then
      vim.defer_fn(poll, 50)
      return
    end

    local progress = file_picker.get_scan_progress()
    if progress.is_scanning then
      picker_ui.update_status(progress)
      vim.defer_fn(poll, 50)
      return
    end

    picker_ui.state.last_status_info = nil
    picker_ui.update_results()
  end

  poll()
  return true
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fff_*",
  callback = function ()
    vim.keymap.set({ "n", "i" }, "<A-c>", function ()
      local next_root = search_cwd and search_root or vim.fn.getcwd()
      if change_picker_root(vim.fs.normalize(next_root)) then
        search_cwd = not search_cwd
      end
    end, { buffer = true, desc = "Toggle Root/CWD" }
    )
  end,
})

fff.setup({
  prompt = "> ",
  grep = {
    modes = { "plain", "fuzzy", "regex" },
  },
})
