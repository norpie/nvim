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
        keys = {
            { 'w', function() require('spider').motion('w') end },
            { 'w', function() require('spider').motion('w') end, mode = 'x' },
            { 'e', function() require('spider').motion('e') end },
            { 'e', function() require('spider').motion('e') end, mode = 'x' },
            { 'b', function() require('spider').motion('b') end },
            { 'b', function() require('spider').motion('b') end, mode = 'x' },
        }
    },
}
