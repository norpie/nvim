return {
    'folke/zen-mode.nvim',
    'levouh/tint.nvim',
    'folke/twilight.nvim',
    'stevearc/dressing.nvim',
    'stevearc/aerial.nvim',
    --'wellle/context.vim' -- TODO: Look into
    'David-Kunz/markid',
    'RRethy/vim-illuminate',
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup()
        end
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },
    {
        'folke/todo-comments.nvim',
        config = function()
            require('todo-comments').setup()
        end
    },
    {
        'nacro90/numb.nvim',
        config = function()
            require('numb').setup()
        end
    },

}
