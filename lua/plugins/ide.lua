return {
    {
        'andrewferrier/debugprint.nvim',
        version = "*",
        event = 'VeryLazy',
        keys = {
            { '<leader>da', function() return require('debugprint').debugprint({ above = true }) end, expr = true, desc = "add debug print above" },
            { '<leader>du', function() return require('debugprint').debugprint() end,                 expr = true, desc = "add debug print under" }
        },
        config = function()
            local opts = {
                create_keymaps = false,
                create_commands = true
            }
            require("debugprint").setup(opts)
        end
    },
    {
        'ethanholz/nvim-lastplace',
        event = 'BufReadPost',
        config = function()
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
        keys = {
            { '<leader>es', '<cmd>ExecutorSetCommand<cr>', desc = 'Set executor command' },
            {
                '<leader>er',
                '<cmd>ExecutorRun<cr>',
                desc = 'Run executor command, if not set prompt'
            },
        },
    },
    {
        'ahmedkhalf/project.nvim',
        event = 'VeryLazy',
        config = function()
            local opts = {
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "src" },
                detection_methods = { "pattern", "lsp" },
                silent_chdir = false
            }
            require("project_nvim").setup(opts)
        end,

    },
}
