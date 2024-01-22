return {
    -- {
    --     "nvim-neotest/neotest",
    --     dependencies = {
    --         'rouge8/neotest-rust',
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     config = function()
    --         require("neotest").setup({
    --             adapters = {
    --                 require("neotest-rust")
    --             }
    --         })
    --     end
    -- } -- TODO: Enable later
    {
        'michaelb/sniprun',
        build = 'sh install.sh',
        keys = {
            { '<leader>er', function() vim.cmd("'<,'>SnipRun") end },
        }
    }
}
