return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        --'Zane-/cder.nvim', -- BUG: change config to only show working dir and subs
        'nvim-telescope/telescope-fzy-native.nvim',
        'nvim-lua/plenary.nvim'
    },
    cmd = 'Telescope',
    keys = {
        { '<C-p>', '<cmd>Telescope find_files<cr>', { silent = true } },
        --{ '<Leader>oc', '<cmd>Telescope cder<CR>' }
    },
    config = function()
        require("config.telescope-nvim").setup()
    end
}
