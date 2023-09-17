return {
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        cmd = "HopWord",
        dependencies = 'mfussenegger/nvim-treehopper',
        keys = {
            { '<leader>H', ':HopWord<CR>', desc = "Hop Word" }
        },
        config = function()
            require('hop').setup()
        end
    },
    {
        "chrisgrieser/nvim-spider",
        init = function()
            -- vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
            -- vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
            -- vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
            -- vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
        end,
        keys = {
            { 'w', function() require('spider').motion('w') end },
            { 'w', function() require('spider').motion('w') end, mode = 'x' },
            { 'e', function() require('spider').motion('e') end },
            { 'e', function() require('spider').motion('e') end, mode = 'x' },
            { 'b', function() require('spider').motion('b') end },
            { 'b', function() require('spider').motion('b') end, mode = 'x' },
        }
    },
    {
        'jinh0/eyeliner.nvim',
        event = 'VeryLazy',
        config = function()
            require('eyeliner').setup {
                highlight_on_key = false, -- show highlights only after keypress
                dim = false               -- dim all other characters if set to true (recommended!)
            }
        end
    },
    {
        "ghillb/cybu.nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<s-tab>", "<cmd>CybuPrev<cr>" },
            { "<tab>",   "<cmd>CybuNext<cr>" }
        },
        config = function()
            require('cybu').setup()
        end,
    }
}
