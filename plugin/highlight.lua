local highligh_provider = "plugins.arborist"

local ok, err = pcall(require, highligh_provider)

if not ok then
  vim.notify("Failed to load highlight provider: " .. err, vim.log.levels.ERROR)
  return
end
