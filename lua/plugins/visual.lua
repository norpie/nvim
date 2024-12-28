return {
    {
        'folke/zen-mode.nvim',
        keys = {
            { '<Leader>z', '<cmd>ZenMode<CR>', { silent = true } }

        },
        dependencies = {
            'folke/twilight.nvim',
        },
        opts = {
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
                vim.opt.wrap = true
                vim.opt.linebreak = true
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                vim.opt.wrap = false
                vim.opt.linebreak = false
            end,
        }
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function()
            require('colorizer').setup({
                filetypes = { "*" },
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
