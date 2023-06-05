return {
    'wellle/targets.vim',
    'AndrewRadev/splitjoin.vim',
    'tpope/vim-repeat',
    'matze/vim-move',
    'junegunn/vim-easy-align',
    'godlygeek/tabular',
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    },
    {
        'McAuleyPenney/tidy.nvim',
        config = function()
            require('tidy').setup()
        end
    },
    {
        'abecodes/tabout.nvim',
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
