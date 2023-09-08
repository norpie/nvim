return {
    'wellle/targets.vim',
    {
        'matze/vim-move',
        keys = {
            { '<A-j>', '<Plug>MoveBlockDown' },
            { '<A-k>', '<Plug>MoveBlockUp' }
        }
    },
    --'junegunn/vim-easy-align',
    --'godlygeek/tabular',
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
        'abecodes/tabout.nvim',
        event = "InsertEnter",
        config = function()
            require('config/tabout').setup()
        end
    },
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup()
        end
    },
}
