-- register custom :reload command to source config
vim.api.nvim_create_user_command('Reload', function()
  vim.cmd('source $CFG')
end, {})

vim.api.nvim_create_user_command('Update', function()
    vim.pack.update()
end, {})
