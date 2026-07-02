require('lib.packages').add({
    'OXY2DEV/markview.nvim'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        require('markview').setup({})
    end
})
