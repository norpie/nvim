return {
    { -- Additioanl text objects
        'wellle/targets.vim',
        event = "VeryLazy",
    },
    { -- Surround text objects with quotes, brackets, etc.
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {
            keymaps = {
                visual = "s",
                normal = "s"
            }
        }
    },
    { -- Clean up trailing whitespace
        'McAuleyPenney/tidy.nvim',
        event = 'VeryLazy',
        config = function()
            require('tidy').setup()
        end,
    },
    { -- Go to last location on file open
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
    { -- Auto pairs for brackets, quotes, etc.
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    { -- Possiblity to view undo history in a tree
        'mbbill/undotree',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' }
        }
    },
    { -- Make undo history more resilient
        'kevinhwang91/nvim-fundo',
        event = 'VeryLazy',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        build = function() require('fundo').install() end,
        opts = {}
    }
}
