return -- Treesitter
{
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            -- { 'norpie/markid', branch = 'fix-issue-9' },
            'https://github.com/David-Kunz/markid',
            'nvim-treesitter/nvim-treesitter-textobjects', -- TODO: config
            'RRethy/nvim-treesitter-textsubjects',         -- TODO: config
            'RRethy/vim-illuminate',
            'RRethy/nvim-treesitter-endwise',
            {
                'abecodes/tabout.nvim',
                enabled = false,
                lazy = true,
                config = function()
                    require('tabout').setup()
                end,
            },
        },
        build = ':TSUpdate',
        -- event = { 'UIEnter' },
        config = function()
            require('nvim-treesitter.install').compilers = { 'gcc', 'clang++' }
            require('nvim-treesitter.configs').setup {
                -- auto_install = true,
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
        ft = "surql",
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
