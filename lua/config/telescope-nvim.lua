local M = {}

function M.setup()
    M.config()
    M.extensions()
    M.theme()
end

function M.extensions()
    local telescope = require("telescope")
    telescope.load_extension("noice")
    --telescope.load_extension('cder')
    telescope.load_extension('fzy_native')
end

function M.config()
    require('telescope').setup({
        --pickers = {
        --    find_files = {
        --        theme = "dropdown",
        --    }
        --},
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
            }
        },
    })
end

function M.theme()
    local colors = require('config.theme').palette()
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

return M
