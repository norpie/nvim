return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'petertriho/cmp-git',
            'dmitmel/cmp-cmdline-history',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'L3MON4D3/LuaSnip',
        },
        config = function()
            require('config/cmp').setup()
        end,
        event = 'InsertEnter'
    },
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        config = function()
            require('config/luasnip').setup()
        end,
    }
}
