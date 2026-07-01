-- register custom :reload command to source config
vim.api.nvim_create_user_command('Reload', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end
  vim.cmd('source $CFG')
end, {})
