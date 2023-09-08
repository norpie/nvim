return {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                notify = false,
                mini = false,
            },
            color_overrides = {
                macchiato = {
                    crust = '#202233'
                }
            }
        })
        vim.cmd.colorscheme 'catppuccin-macchiato'
    end
}
