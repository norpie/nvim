local M = {}

function M.setup_keys(buffer)
    vim.keymap.set(
        'n',
        '<leader>q',
        vim.lsp.buf.code_action,
        { buffer = buffer, noremap = true, silent = true, desc = 'Code action' }
    )
    vim.keymap.set(
        'n',
        '<leader>r',
        vim.lsp.buf.rename,
        { buffer = buffer, noremap = true, silent = true, desc = 'Rename' }
    )
    vim.keymap.set(
        'n',
        '<leader>h',
        vim.lsp.buf.hover,
        { buffer = buffer, noremap = true, silent = true, desc = 'Show hover' }
    )
    vim.keymap.set(
        'n',
        'gd',
        vim.lsp.buf.definition,
        { buffer = buffer, noremap = true, silent = true, desc = 'Go to definition' }
    )
    vim.keymap.set(
        'n',
        'gD',
        vim.lsp.buf.declaration,
        { buffer = buffer, noremap = true, silent = true, desc = 'Go to declaration' }
    )
end

function M.capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

function M.on_attach(client, buffer)
    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, buffer)
    end
    M.setup_keys(buffer)
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = true,
        -- show_diagnostic_autocmds = { "BufWritePost" },
        show_diagnostic_autocmds = { 'InsertLeave', 'BufWritePost' },
    })
end

function M.setup()
    local servers = {
        'cssls',
        'emmet_ls',
        'bashls',
        'html',
        'jsonls',
        'ts_ls',
        'tailwindcss',
        --'jedi_language_server',
        'pyright',
        'texlab',
        'clangd',
        'volar',
        'svelte',
        'nil_ls',
        'gopls',
        'vimls',
        'taplo',
        'lua_ls',
    }
    local lspconfig = require 'lspconfig'
    for _, server in pairs(servers) do
        if vim.fn.filereadable(vim.fn.stdpath 'config' .. '/lua/lsp/servers/' .. server .. '.lua') == 1 then
            local settings = require('lsp.servers.' .. server).settings()
            local filetypes = require('lsp.servers.' .. server).filetypes()
            local cmd = require('lsp.servers.' .. server).cmd()
            lspconfig[server].setup {
                on_attach = M.on_attach,
                capabilities = M.capabilities(),
                cmd = cmd,
                settings = settings,
                filetypes = filetypes,
            }
        else
            lspconfig[server].setup {
                on_attach = M.on_attach,
                capabilities = M.capabilities(),
            }
        end
    end
    local custom_servers = {
        'surql',
    }
    -- For every custom server, are we in this filetype?
    for _, server in pairs(custom_servers) do
        if vim.fn.filereadable(vim.fn.stdpath 'config' .. '/lua/lsp/servers/' .. server .. '.lua') == 1 then
            local cs = require('lsp.servers.' .. server)
            cs.setup()
        end
    end
end

return M
