local M = {}

function M.is_nvim_config()
    if not vim.bo.filetype == "lua" then
        return false
    end
    -- TODO: check if the file is in the nvim config directory
    return true
end

return M
