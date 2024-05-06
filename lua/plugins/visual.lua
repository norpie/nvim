return {
    {
        'folke/zen-mode.nvim',
        keys = {
            { '<Leader>z', '<cmd>ZenMode<CR>', { silent = true } }

        },
        dependencies = {
            'folke/twilight.nvim',
        }
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function()
            require('colorizer').setup({
                '*';
            })
        end
    },
    {
        'utilyre/sentiment.nvim',
        event = 'VeryLazy',
        version = "*",
        config = true,
    },
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require('todo-comments').setup()
        end
    },
    {
        'nacro90/numb.nvim',
        event = 'VeryLazy',
        config = function()
            require('numb').setup()
        end
    },

}
