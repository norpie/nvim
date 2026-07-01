require('lib.packages').add({
    "zbirenbaum/copilot.lua",
    "fang2hou/blink-copilot"
})

local copilot = require("copilot")
copilot.setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
        markdown = true,
        help = true,
    },
})

local M = {}

function M.providers()
    return {
        copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
        },
    }
end

return M
