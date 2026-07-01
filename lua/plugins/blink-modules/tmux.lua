require('lib.packages').add('barrettruth/blink-cmp-tmux')

local M = {}

function M.providers()
    return {
        tmux = {
            name = 'Tmux',
            module = 'blink-cmp-tmux',
        },
    }
end

return M
