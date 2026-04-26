local is_nix = vim.g.nix_info_plugin_name ~= nil

if not is_nix then
  require("config.non_nix_download")
end

require("config")
