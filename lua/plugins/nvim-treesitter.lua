return -- Treesitter
{
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'David-Kunz/markid',
            'nvim-treesitter/nvim-treesitter-textobjects', -- TODO: config
            'RRethy/nvim-treesitter-textsubjects',         -- TODO: config
            'RRethy/vim-illuminate',
            'RRethy/nvim-treesitter-endwise',
            {
                'abecodes/tabout.nvim',
                config = function()
                    require('tabout').setup()
                end,
            },
        },
        build = ':TSUpdate',
        event = { 'VeryLazy' },
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = "all",
                sync_install = false,
                ignore_install = {},
                autotag = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'latex', 'markdown' }
                },
                markid = {
                    enable = true
                },
                endwise = {
                    enable = true,
                },
            }
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
        'windwp/nvim-ts-autotag',
        ft = { 'astro', 'glimmer', 'handlebars',
            'html', 'javascript', 'jsx',
            'markdown', 'php', 'rescript',
            'svelte', 'tsx', 'typescript',
            'vue', 'xml'
        }
    }
}
