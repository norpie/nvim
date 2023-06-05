local M = {}

function M.setup()
    M.overrides()
    M.set()
end

function M.overrides()
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
end

function M.palette()
    return require("catppuccin.palettes").get_palette "macchiato"
end

function M.set()
    vim.cmd.colorscheme 'catppuccin-macchiato'
end

return M
