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
                    plain_below = "<leader>du",
                    plain_above = "<leader>da",
                    variable_below = "<leader>dU",
                    variable_above = "<leader>dA",
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
        "igorlfs/nvim-dap-view",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "Weissle/persistent-breakpoints.nvim",
            "t-troebst/perfanno.nvim",
            "ofirgall/goto-breakpoints.nvim",
            "Willem-J-an/visidata.nvim",
        },
        opts = {},
    },
    {
        "nvim-neotest/neotest",
        event = "VeryLazy",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "olimorris/neotest-phpunit",
            "andythigpen/nvim-coverage"
        },
        config = function()
            local opts = {
                adapters = {
                    -- require('rustaceanvim.neotest')
                    -- require("neotest-phpunit")
                },
            }
        end,
    }
}
