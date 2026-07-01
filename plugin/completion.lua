local completion_provider = "plugins.blink"

local ok, err = pcall(require, completion_provider)

if not ok then
  vim.notify("Failed to load completion provider: " .. err, vim.log.levels.ERROR)
  return
end
