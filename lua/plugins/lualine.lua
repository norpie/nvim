local packages = require("lib.packages")

packages.add({
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim'
})

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'copilot', },
        lualine_c = { 'diff', 'diagnostics' },
        -- right
        lualine_x = { '' },
        lualine_y = { 'filetype' },
        lualine_z = { '' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})
