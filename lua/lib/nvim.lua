local M = {}

local env = require('lib.env')

function M.is_nvim_config()
    if not vim.bo.filetype == "lua" then
        return false
    end
    local config_dir = env.config_dir()
    if not vim.fn.fnamemodify(vim.fn.expand("%:p"), ":p"):find(config_dir, 1, true) then
        return false
    end
    return true
end

return M
