return -- Treesitter
{
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'windwp/nvim-ts-autotag',
        'p00f/nvim-ts-rainbow',
        'nvim-treesitter/nvim-treesitter-context',
        'm-demare/hlargs.nvim',
        'RRethy/nvim-treesitter-endwise',
        'nvim-treesitter/nvim-treesitter-textobjects',     --TODO: config
        'RRethy/nvim-treesitter-textsubjects',             --TODO: config
        'mfussenegger/nvim-treehopper',
        'dariuscorvus/tree-sitter-surrealdb.nvim',
    },
    build = ':TSUpdate',
    config = function()
        require('config/treesitter').setup()
    end
}
