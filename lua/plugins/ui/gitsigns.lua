vim.api.nvim_set_hl(0, "GitSignsAddNr", { bg = "#1f3d2b", fg = "#8fd694", bold = true })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { bg = "#3d3420", fg = "#f0c674", bold = true })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { bg = "#3d2226", fg = "#e06c75", bold = true })

local M = {}

function M.opts()
    return
    {
        signcolumn = false,
        numhl = true,
        linehl = false,
    }
end

return M
