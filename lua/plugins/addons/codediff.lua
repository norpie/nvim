local M = {}

function M.opts()
    vim.api.nvim_create_user_command("Diff", function()
        vim.cmd("CodeDiff")
    end, {})
    return {}
end

return M
