local status_provider = "plugins.lualine"

local ok, err = pcall(require, status_provider)

if not ok then
  vim.notify("Failed to load status provider: " .. err, vim.log.levels.ERROR)
  return
end
