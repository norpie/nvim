local M = {}

M.setup = function()
    local group = 'surrealql-lsp-server'
    vim.api.nvim_create_augroup(group, { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'surql',
        callback = function()
            vim.lsp.set_log_level 'debug'
            require('vim.lsp.log').set_format_func(vim.inspect)

            local client = vim.lsp.start {
                name = 'surrealql-lsp-server',
                cmd = { '/home/norpie/repos/surrealql-lsp/target/release/surrealql-lsp-server' },
            }

            if not client then
                vim.notify('Failed to start surrealql-lsp-server', vim.log.levels.ERROR)
                return
            end

            vim.lsp.buf_attach_client(0, client)
        end,
    })
end

return M
