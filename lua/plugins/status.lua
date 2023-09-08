return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto', -- based on current vim colorscheme
                    -- not a big fan of fancy triangle separators
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    -- left
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    -- right
                    lualine_x = { '' },
                    lualine_y = { 'filetype' },
                    lualine_z = { 'hostname' }
                },
                inactive_sections = {
                    lualine_a = { 'filename' },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            })
        end
    },
}
