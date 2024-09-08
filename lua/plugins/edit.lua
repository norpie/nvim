return {
    {
        'wellle/targets.vim',
        event = 'VeryLazy',
    },
    {
        'matze/vim-move',
        keys = {
            { '<A-j>', '<Plug>MoveBlockDown' },
            { '<A-k>', '<Plug>MoveBlockUp' },
        },
    },
    {
        'gbprod/substitute.nvim',
        keys = {
            {
                's',
                function()
                    require('substitute.exchange').operator()
                end,
                noremap = true,
            },
            {
                'S',
                function()
                    require('substitute.exchange').line()
                end,
                noremap = true,
            },
        },
        config = function()
            require('substitute').setup {}
        end,
    },
    {
        'AndrewRadev/splitjoin.vim',
        keys = {
            { 'J', '<cmd>SplitjoinJoin<cr>' },
            { 'K', '<cmd>SplitjoinSplit<cr>' },
        },
    },
    {
        'AndrewRadev/switch.vim',
        keys = {
            { '<leader>s', '<cmd>Switch<cr>' },
        },
    },
    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup {}
        end,
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
            { '<leader>c', '<cmd>CommentToggle<cr>', desc = 'Comment toggle' },
            { '<leader>c', ':<C-u>call CommentOperator(visualmode())<CR>', mode = 'x' },
        },
        config = function()
            require('nvim_comment').setup {
                create_mappings = false,
                hook = function()
                    require('ts_context_commentstring.internal').update_commentstring()
                end,
            }
        end,
    },
    {
        'McAuleyPenney/tidy.nvim',
        event = 'VeryLazy',
        config = function()
            require('tidy').setup()
        end,
    },
}
