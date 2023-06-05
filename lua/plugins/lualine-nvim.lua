return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('config/status').setup()
    end,
    dependencies = {
        'tiagovla/scope.nvim',
        --'akinsho/bufferline.nvim',
        'b0o/incline.nvim'
    }
}
