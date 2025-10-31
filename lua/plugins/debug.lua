return {
    {
        "andrewferrier/debugprint.nvim",
        dependencies = {
            "echasnovski/mini.nvim" -- Needed for :ToggleCommentDebugPrints(NeoVim 0.9 only)
        },
        event = 'VeryLazy',
        opts = {
            keymaps = {
                normal = {
                    plain_below = "<leader>dpu",
                    plain_above = "<leader>dpa",
                    variable_below = "<leader>dpU",
                    variable_above = "<leader>dpA",
                },
            }
        },
        version = "*", -- Remove if you DON'T want to use the stable version
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
    },
    {
        enabled = false,
        "mfussenegger/nvim-dap",
        dependencies = {
            "igorlfs/nvim-dap-view",
            "nvim-neotest/nvim-nio",
            "Weissle/persistent-breakpoints.nvim",
            "t-troebst/perfanno.nvim",
            "ofirgall/goto-breakpoints.nvim",
            "Willem-J-an/visidata.nvim",
        },
        opts = {

        },
    },
    {
        "nvim-neotest/neotest",
        event = "VeryLazy",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "olimorris/neotest-phpunit",
            "andythigpen/nvim-coverage",
            "mrcjkb/rustaceanvim"  -- Add rustaceanvim as dependency for neotest
        },
        keys = {
            { '<leader>tr', function() require("neotest").run.run() end, { silent = true } },
            { '<leader>ts', '<cmd>Neotest summary<CR>',                  { silent = true } },
            { '<leader>tn', '<cmd>Neotest nearest<CR>',                  { silent = true } }
        },
        config = function()
            local opts = {
                adapters = {
                    require('rustaceanvim.neotest')
                    -- require("neotest-phpunit")
                },
            }
            require("neotest").setup(opts)
        end,
    }
}
