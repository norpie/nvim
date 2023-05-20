local M = {}

function M.settings()
    local settings = {}
    return settings
end

function M.filetypes()
    local filetypes = { 'html', 'tera', 'htmldjango', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'vue' }
    return filetypes
end

function M.cmd()
    local cmd = "emmet-ls"
end

return M
