require('lib.packages').add({
    'nvim-telescope/telescope.nvim',
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    }
})

require('telescope').setup({})

local ivy = require('telescope.themes').get_ivy({})

vim.keymap.set('n', '<leader>sd', function ()
   require('telescope.builtin').find_files(ivy)
end)

vim.keymap.set('n', '<leader>sf', function ()
    require('telescope.builtin').live_grep(ivy)
end)
