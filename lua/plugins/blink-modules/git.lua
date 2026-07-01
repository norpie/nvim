require('lib.packages').add('Kaiser-Yang/blink-cmp-git')

local M = {}

function M.providers()
    return {
        git = {
            module = 'blink-cmp-git',
            name = 'Git',
            opts = {},
        },
    }
end

return M
