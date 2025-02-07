return
{
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = 'VeryLazy',
        opts = {}
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'https://github.com/David-Kunz/markid',
            'RRethy/vim-illuminate', -- { 'ehpi/vim-illuminate', branch = 'remove-vim-region' }, -- This is ready for the nightly
            'RRethy/nvim-treesitter-endwise',
            'RRethy/nvim-treesitter-textsubjects',
            {
                'hiphish/rainbow-delimiters.nvim',
                -- event = "",
                lazy = false,
                main = "rainbow-delimiters.setup",
                opts = {
                    highlight = {
                        'RainbowDelimiterYellow',
                        'RainbowDelimiterBlue',
                        'RainbowDelimiterOrange',
                        'RainbowDelimiterGreen',
                        'RainbowDelimiterViolet',
                        'RainbowDelimiterCyan',
                        'RainbowDelimiterRed',
                    },
                }
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
                textsubjects = {
                    enable = true,
                    prev_selection = ',',
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                    },
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
