local M = {}

function M.opts()
    vim.autocmd("DirEnter", {
        callback = function()
            vim.cmd('Fyler')
        end,
    })
    return {}
end

return M
