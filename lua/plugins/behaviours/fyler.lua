local M = {}

function M.opts()
    vim.autocmd("BufRead", {
        callback = function()
            vim.cmd('Fyler')
        end,
    })
    return {}
end

return M
