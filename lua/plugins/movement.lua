return {
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
}
