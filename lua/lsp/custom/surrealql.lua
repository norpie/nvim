-- Custom SurrealQL language server
-- This sets up the custom SurrealQL LSP server

local name = 'surrealql-lsp-server'
local group = name

vim.api.nvim_create_augroup(group, { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'surql',
    callback = function()
        vim.lsp.set_log_level('debug')
        require('vim.lsp.log').set_format_func(vim.inspect)

        local client = vim.lsp.start({
            name = name,
            cmd = { '/home/norpie/repos/surrealql-lsp/target/release/surrealql-lsp-server' },
        })

        if not client then
            vim.notify('Failed to start ' .. name, vim.log.levels.ERROR)
            return
        end

        vim.lsp.buf_attach_client(0, client)
    end,
})
