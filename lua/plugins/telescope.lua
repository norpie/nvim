return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-fzy-native.nvim',
        'nvim-lua/plenary.nvim',
        "piersolenski/telescope-import.nvim",
    },
    cmd = 'Telescope',
    keys = {
        { '<C-p>', '<cmd>Telescope find_files<cr>', { silent = true } },
        { '<M-p>', '<cmd>Telescope live_grep<cr>',  { silent = true } },
        { '<leader>i', '<cmd>Telescope import<cr>',     { silent = true } },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({
            pickers = {
                find_files = {
                    -- theme = "dropdown",
                },
                colorscheme = {
                    enable_preview = true,
                },
            },
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    }
                },
                sorting_strategy = 'ascending',
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
                import = {
                    insert_at_top = true
                }
            },
        })

        telescope.load_extension("noice")
        telescope.load_extension('fzy_native')
        telescope.load_extension("import")

        local colors = require('util').palette()
        if not colors then
            return
        end
        local TelescopePrompt = {
            TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
            TelescopeMatching = { fg = colors.text, bg = colors.surface0 },
            TelescopeResultsTitle = { fg = colors.crust, bg = colors.crust },
            TelescopeResultsBorder = { fg = colors.crust, bg = colors.crust },
            TelescopeResultsNormal = { fg = colors.text, bg = colors.crust },

            TelescopePromptPrefix = { fg = colors.text, bg = colors.surface0 },
            TelescopePromptNormal = { fg = colors.text, bg = colors.surface0 },
            TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
            TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },

            TelescopePreviewNormal = { fg = colors.text, bg = colors.crust },
            TelescopePreviewBorder = { fg = colors.crust, bg = colors.crust },
            TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
        }
        for hl, col in pairs(TelescopePrompt) do
            vim.api.nvim_set_hl(0, hl, col)
        end
    end
}
