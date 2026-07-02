local M = {}

function M.opts()
    vim.keymap.set('n', 'gb', function()
            require("snipe").open_buffer_menu()
        end,
        { desc = "Open Snipe buffer menu" })
    return {}
end

return M
