return {
    {
        'tpope/vim-fugitive',
        cmd = "Git",
    },
    {
        'rbong/vim-flog',
        cmd = {
            "Flog",
            "Flogsplit"
        },
        keys = {
            { '<Leader>gb', '<cmd>Flogsplit' }
        },
        dependencies = {
            'tpope/vim-fugitive'
        }
    },
    {
        'rhysd/git-messenger.vim',
        cmd = "GitMessenger",
        keys = {
            { '<leader>gm', '<cmd>GitMessenger' }
        }
    }
}
