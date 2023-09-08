return -- Treesitter
{
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'p00f/nvim-ts-rainbow',
            'm-demare/hlargs.nvim',
            'nvim-treesitter/nvim-treesitter-textobjects', -- TODO: config
            'RRethy/nvim-treesitter-textsubjects',         -- TODO: config
            'David-Kunz/markid',
        },
        build = ':TSUpdate',
        event = 'VeryLazy',
        config = function()
            require('config.treesitter').setup()
        end
    },
    {
        'dariuscorvus/tree-sitter-surrealdb.nvim',
        build = ':TSUpdate surrealdb',
        ft = {
            'surql',
        },
        config = function()
            require("tree-sitter-surrealdb").setup()
        end
    },
    {
        'RRethy/nvim-treesitter-endwise',
        ft = {
            'ruby', 'lua', 'vimscript', 'bash', 'elixir', 'fish'
        }
    },
    {
        'windwp/nvim-ts-autotag',
        ft = {
            'astro',
            'glimmer',
            'handlebars',
            'html',
            'javascript',
            'jsx',
            'markdown',
            'php',
            'rescript',
            'svelte',
            'tsx',
            'typescript',
            'vue',
            'xml'
        }
    }
}
