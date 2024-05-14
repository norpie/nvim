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
            { '<leader>gg', '<cmd>Neogit<CR>' },
        },
    },
    {
        'rbong/vim-flog',
        cmd = {
            'Flog',
            'Flogsplit',
        },
        keys = {
            { '<Leader>gl', '<cmd>Flogsplit<CR>' },
        },
        dependencies = {
            'tpope/vim-fugitive',
        },
    },
    {
        'rhysd/git-messenger.vim',
        cmd = 'GitMessenger',
        keys = {
            { '<leader>gb', '<cmd>GitMessenger<CR>' },
        },
    },
    --{ -- TODO: Enable later, maybe
    --    'lewis6991/gitsigns.nvim'
    --},
    -- { -- TODO: Enable later, when needed
    --     'pwntester/octo.nvim',
    -- }
}
