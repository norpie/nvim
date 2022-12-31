local M = {}

function M.settings()
    --local rt = require("rust-tools")
    --local opts = {
    --    server = {
    --        cmd = { "/usr/bin/ra-multiplex" },
    --    }
    --}
    --rt.setup(opts)
    local settings = {}
    return settings
end

function M.cmd()
    local cmd = { "ra-multiplex" }
    return cmd
end

function M.filetypes()
    local filetypes = {
        'rs',
        'rust'
    }
    return filetypes
end

return M
