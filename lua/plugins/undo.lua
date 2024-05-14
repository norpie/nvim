return {
    {
        'mbbill/undotree',
        keys = {
            {'<leader>u', vim.cmd.UndotreeToggle}
        }
    },
    {
        'kevinhwang91/nvim-fundo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        event = 'VeryLazy',
        build = function() require('fundo').install() end,
        config = function() require('fundo').setup() end
    }
}
