return {
    'folke/neodev.nvim',
    'nvim-lua/plenary.nvim',
    'tpope/vim-vinegar',
    {
        'ethanholz/nvim-lastplace',
        init = function()
            require 'nvim-lastplace'.setup {
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
                lastplace_open_folds = true
            }
        end
    },
    {
        'google/executor.nvim',
        keys = {
            { '<leader>es', '<cmd>ExecutorSetCommand<cr>', desc = 'Set executor command' },
            {
                '<leader>er',
                '<cmd>ExecutorRun<cr>',
                desc = 'Run executor command, if not set prompt'
            },
        },
    }
}
