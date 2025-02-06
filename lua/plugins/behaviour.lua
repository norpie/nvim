return {
    { -- Additioanl text objects
        'wellle/targets.vim',
        event = "VeryLazy",
    },
    { -- Surround text objects with quotes, brackets, etc.
        "kylechui/nvim-surround",
        dependencies = {
            {
                "roobert/surround-ui.nvim",
                dependencies = {
                    "folke/which-key.nvim",
                },
                config = function()
                    require("surround-ui").setup({
                        root_key = "S"
                    })
                end,
            }
        },
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
    },
    {
        'folke/zen-mode.nvim',
        keys = {
            { '<Leader>z', '<cmd>ZenMode<CR>', { silent = true } }

        },
        dependencies = {
            'folke/twilight.nvim',
        },
        opts = {
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
                vim.opt.wrap = true
                vim.opt.linebreak = true
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                vim.opt.wrap = false
                vim.opt.linebreak = false
            end,
        }
    }
}
