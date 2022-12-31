local M = {}

function M.settings()
    local settings = {}
    return settings
end

function M.filetypes()
    local filetypes = {
        'html',
        'tera',
        'htmldjango'
    }
    return filetypes
end

function M.cmd()
    local cmd = { "vscode-html-language-server", "--stdio" }
    return cmd
end

return M
