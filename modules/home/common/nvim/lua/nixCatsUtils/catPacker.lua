--[[
  This directory is the luaUtils template.
  You can choose what things from it that you would like to use.
  And then delete the rest.
  Everything in this directory is optional.
--]]

local M = {}

function M.setup(plugins)
  if not vim.g[ [[nixCats-special-rtp-entry-nixCats]] ] and vim.pack and vim.pack.add then
    vim.pack.add(plugins)
  end
end

return M
