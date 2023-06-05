return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'Zane-/cder.nvim', -- BUG: change config to only show working dir and subs
        'nvim-telescope/telescope-fzy-native.nvim'
    },
    config = function()
        require("config.telescope-nvim").setup()
    end
}
