return {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('config.theme').setup()
    end
}
