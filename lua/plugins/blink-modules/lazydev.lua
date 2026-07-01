local packages = require("lib.packages")

packages.add({
    'https://github.com/folke/lazydev.nvim',
})

local M = {}

function M.should_enable()
    local nvim = require('lib.nvim')
    return nvim.is_nvim_config()
end

function M.sources()
    return {
        'lazydev'
    }
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
