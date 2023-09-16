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
        'terrortylor/nvim-comment',
        keys = {
            { '<leader>c', '<cmd>CommentToggle<cr>'},
            { '<leader>c', ':<C-u>call CommentOperator(visualmode())<CR>', mode = 'x' }
        },
        config = function()
            require('nvim_comment').setup({
                create_mappings = false,
            })
        end
    },
    {
        'McAuleyPenney/tidy.nvim',
        event = "VeryLazy",
        config = function()
            require('tidy').setup()
        end
    },
}
