local M = {}

function M.settings()
    local rt = require("rust-tools")
    rt.setup()
    local settings = {}
    return settings
end

function M.filetypes()
    local filetypes = {
        'rs'
    } -- TODO: add filetypes
    return filetypes
end

return M
