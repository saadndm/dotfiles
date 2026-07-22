require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      default = "msg",
      emsg = "msg",
      echo = "msg",
      echoerr = "msg",
      list_cmd = "msg",
      lua_error = "pager",
      progress = "pager",
      rpc_error = "pager",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      verbose = "pager",
    },
    msg = {
      height = 0.3,
      timeout = 4000,
    },
    pager = {
      height = 0.5,
    },
  },
})

local f = function ()
  local ui2 = require("vim._core.ui2")
  local win = ui2.wins and ui2.wins.msg

  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_option_value(
      "winhighlight", "Normal:NormalFloat,FloatBorder:FloatBorder", { scope = "local", win = win }
    )
    vim.api.nvim_set_option_value("wrap", true, { scope = "local", win = win })
    vim.api.nvim_set_option_value("linebreak", true, { scope = "local", win = win })
  end
end

Config.new_autocmd("FileType", "msg", f)

local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos

local function msg_width(buf, max_width)
  local width = 1

  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  return math.min(width, max_width)
end

msgs.set_pos = function (tgt)
  orig_set_pos(tgt)

  local win = ui2.wins and ui2.wins.msg
  if (tgt == "msg" or tgt == nil) and win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_set_config(ui2.wins.msg, {
      relative = "editor",
      anchor = "NE",
      row = 1,
      col = vim.o.columns - 1,
      width = msg_width(vim.api.nvim_win_get_buf(win), math.floor(vim.o.columns * 0.5)),
      border = "rounded",
    })
  end
end
