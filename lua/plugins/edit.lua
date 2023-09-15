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
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        branch = 'v0.6',
        opts = {
            --Config goes here
        },
    },
    {
        'McAuleyPenney/tidy.nvim',
        event = "VeryLazy",
        config = function()
            require('tidy').setup()
        end
    },
}
