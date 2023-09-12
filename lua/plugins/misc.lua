return {
    {
        'folke/neodev.nvim',
        ft = 'lua',
    },
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },
    {
        'stevearc/oil.nvim',
        event = 'User DirEnter',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'famiu/bufdelete.nvim',
        keys = {
            { '<leader>bd', '<cmd>Bdelete<cr>' },
            { '<leader>bw', '<cmd>Bwipeout<cr>' },
            { 'bd', 'Bdelete', mode = 'ca', },
            { 'bw', 'Bwipeout', mode = 'ca',  }

        },
        cmd = {
            'Bdelete',
            'Bwipeout'
        }
    },
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
        config = function()
            require("executor").setup({})
        end,
        cmd = '',
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
