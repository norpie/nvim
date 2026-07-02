local finder_provider = "plugins.telescope"

local ok, err = pcall(require, finder_provider)

if not ok then
  vim.notify("Failed to load finder provider: " .. err, vim.log.levels.ERROR)
  return
end
