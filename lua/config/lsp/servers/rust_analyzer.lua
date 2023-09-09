local M = {}

function M.settings()
    --local rt = require("rust-tools")
    --local opts = {
    --    server = {
    --        cmd = { "/usr/bin/ra-multiplex" },
    --    }
    --}
    --rt.setup(opts)
    local settings = {
        ["rust-analyzer"] = {
            check     = {
                command = "clippy",
                extraArgs = { "--all", "--no-deps", "--", "-W", "clippy::all" },
            },
            procMacro = {
                enable = true
            },
        }

    }
    return settings
end

function M.cmd()
    local cmd = { "rust_analyzer" }
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
