return -- Treesitter
{
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        event = 'VeryLazy',
        setup = function()
            require('ts_context_commentstring').setup {
                -- enable_autocmd = false,
            }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            -- { 'norpie/markid', branch = 'fix-issue-9' },
            'https://github.com/David-Kunz/markid',
            'nvim-treesitter/nvim-treesitter-textobjects', -- TODO: config
            'RRethy/nvim-treesitter-textsubjects', -- TODO: config
            -- {
            --     'ehpi/vim-illuminate',
            --     branch = 'remove-vim-region',
            -- },
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
        event = { 'UIEnter' },
        config = function()
            require('nvim-treesitter.install').compilers = { 'gcc', 'clang++' }
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                ensure_installed = 'all',
                sync_install = false,
                autotag = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'latex', 'markdown' },
                    disable = { 'text', 'text,ignore' },
                },
                markid = {
                    enable = true,
                },
                endwise = {
                    enable = true,
                },
            }
        end,
    },
    {
        'dariuscorvus/tree-sitter-surrealdb.nvim',
        ft = 'surql',
        config = function()
            require('tree-sitter-surrealdb').setup()
        end,
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
            'xml',
        },
    },
}
