return {
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'sindrets/diffview.nvim', -- optional - Diff integration

            -- Only one of these is needed, not both.
            'nvim-telescope/telescope.nvim', -- optional
        },
        config = true,
        cmd = 'Neogit',
        keys = {
            { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' },
        },
    },
    {
        'rbong/vim-flog',
        cmd = {
            'Flog',
            'Flogsplit',
        },
        keys = {
            { '<Leader>gl', '<cmd>Flogsplit<CR>', desc = 'Git log' },
        },
        dependencies = {
            'tpope/vim-fugitive',
        },
    },
    {
        'rhysd/git-messenger.vim',
        cmd = 'GitMessenger',
        keys = {
            { '<leader>gb', '<cmd>GitMessenger<CR>', desc = 'Git blame' },
        },
    },
    --{ -- TODO: Enable later, maybe
    --    'lewis6991/gitsigns.nvim'
    --},
    -- { -- TODO: Enable later, when needed
    --     'pwntester/octo.nvim',
    -- }
}
