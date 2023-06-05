return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'petertriho/cmp-git',
        'dmitmel/cmp-cmdline-history',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind.nvim'
    },
    config = function()
        require('config/cmp').setup()
    end
}
