require("lib.packages").add('disrupted/blink-cmp-conventional-commits')

local M = {}

function M.should_enable()
    return true
end

function M.providers()
    return {
        conventional_commits = {
            name = 'Conventional Commits',
            module = 'blink-cmp-conventional-commits',
            enabled = function()
                return vim.bo.filetype == 'gitcommit'
            end,
        }
    }
end

return M
