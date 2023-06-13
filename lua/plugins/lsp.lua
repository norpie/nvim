return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason.nvim',
            lazy = false,
            dependencies = {
                'williamboman/mason-lspconfig.nvim',
            }
        },
        'jose-elias-alvarez/null-ls.nvim', -- TODO: more research
        --'mfussenegger/nvim-jdtls', -- TODO: java
        'simrat39/rust-tools.nvim',
        'simrat39/symbols-outline.nvim',
        'weilbith/nvim-code-action-menu',
        'folke/trouble.nvim',
        'saecki/crates.nvim',
        'kosayoda/nvim-lightbulb',
        'glepnir/lspsaga.nvim',        -- TODO: Figure out if iterests
        'nvim-tree/nvim-web-devicons',
        {
            'SmiteshP/nvim-navic',
            dependencies = {
                {
                    'utilyre/barbecue.nvim',
                    name = 'barbecue',
                    version = '*',
                },
                {
                    'SmiteshP/nvim-navbuddy',
                    opts = { lsp = { auto_attach = true } }
                }
            },
        },
    },
    config = function()
        require('config/lsp').setup()
    end
}
