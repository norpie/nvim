return {
    {
        'andrewferrier/debugprint.nvim',
        version = "*",
        event = 'VeryLazy',
        opts = {
            keymaps = {
                normal = {
                    plain_below = "<leader>du",
                    plain_above = "<leader>da",
                    variable_below = "<leader>dU",
                    variable_above = "<leader>dA",
                },
            }
        }
    },
    {
        'wakatime/vim-wakatime',
    },
    {
        'numToStr/FTerm.nvim',
        config = function()
            require("FTerm").setup({
                dimensions = {
                    height = 0.8,
                    width = 0.8,
                },
                border = 'single' -- or 'double'
            })
        end,
        keys = {
            { '<leader>t', '<cmd>lua require("FTerm").toggle()<cr>', desc = 'Toggle FTerm' },
        },
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
        "LintaoAmons/cd-project.nvim",
        lazy = false,
        init = function()
            require("cd-project").setup({
                project_dir_pattern = { "Cargo.lock", "package.json", ".git" },
                detection_methods = { "pattern", "lsp" },
                silent_chdir = false
            })
        end,
    },
}
