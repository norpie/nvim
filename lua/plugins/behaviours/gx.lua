local M = {}

function M.opts()
    vim.api.set_keymap({ "n", 'x' }, "gx", "<cmd>Browse<cr>")
    return {}
end

return M
