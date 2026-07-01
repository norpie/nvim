require("lib.packages").add('folke/lazydev.nvim')

local M = {}

function M.should_enable()
    local nvim = require('lib.nvim')
    return nvim.is_nvim_config()
end

function M.providers()
    return {
        lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
        },
    }
end

return M
