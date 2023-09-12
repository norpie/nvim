return {
    {
        'wellle/targets.vim',
        event = 'VeryLazy'
    },
    {
        'matze/vim-move',
        keys = {
            { '<A-j>', '<Plug>MoveBlockDown' },
            { '<A-k>', '<Plug>MoveBlockUp' }
        }
    },
    {
        'kylechui/nvim-surround',
        event = "VeryLazy",
        config = function()
            require('nvim-surround').setup({})
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        'McAuleyPenney/tidy.nvim',
        event = "VeryLazy",
        config = function()
            require('tidy').setup()
        end
    },
    {
        'ahmedkhalf/project.nvim',
        event = 'UIEnter',
        config = function()
            require('project_nvim').setup({})
        end
    },
}
