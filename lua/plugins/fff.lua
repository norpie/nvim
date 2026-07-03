require('lib.packages').add({
    {
        'dmtrKovalenko/fff.nvim',
        build = 'nix run .#release'
    }
})

vim.keymap.set('n', '<leader>sd', function()
    require('fff').find_files()
end)

vim.keymap.set('n', '<leader>sf', function()
    require('fff').live_grep()
end)
