M = {}

function M.custom_server(server)
    local name = server.lang .. '-lsp-server'
    local group = name
    vim.api.nvim_create_augroup(group, { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = server.ft,
        callback = function()
            vim.lsp.set_log_level 'debug'
            require('vim.lsp.log').set_format_func(vim.inspect)

            local client = vim.lsp.start {
                name = name,
                cmd = { server.path },
            }

            if not client then
                vim.notify('Failed to start ' .. name, vim.log.levels.ERROR)
                return
            end

            vim.lsp.buf_attach_client(0, client)
        end,
    })
end

return M
