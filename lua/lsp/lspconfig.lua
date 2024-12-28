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
    -- check if blink.cmp is installed
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
        return blink.get_lsp_capabilities()
    else
        return require('cmp_nvim_lsp').default_capabilities()
    end
end

function M.setup_formatter(client, buffer)
    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.keymap.set('n', '<leader>f', function()
    --         vim.lsp.buf.format { async = true }
    --     end, { buffer = buffer, noremap = true, silent = true, desc = 'Format' })
    -- else
    --     vim.keymap.set(
    --         'n',
    --         '<leader>f',
    --         '<cmd>Neoformat<CR>',
    --         { buffer = buffer, noremap = true, silent = true, desc = 'Format' }
    --     )
    -- end
    vim.keymap.set(
        'n',
        '<leader>f',
        function()
            -- Try to use lsp formatter first, if it fails, use neoformat
            local ok, _ = pcall(vim.lsp.buf.format, { async = true })
            if not ok then
                vim.cmd 'Neoformat'
            end
        end,
        { buffer = buffer, noremap = true, silent = true, desc = 'Format' }
    )
end

function M.on_attach(client, buffer)
    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, buffer)
    end
    M.setup_formatter(client, buffer)
    M.setup_keys(buffer)
end

function M.setup(_)
    -- LSP servers --
    local servers = {
        'cssls',
        'emmet_ls',
        'bashls',
        'html',
        'jsonls',
        'ts_ls',
        'tailwindcss',
        'powershell_es',
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
        local capabilities = M.capabilities()
        if vim.fn.filereadable(vim.fn.stdpath 'config' .. '/lua/lsp/servers/' .. server .. '.lua') == 1 then
            local settings = require('lsp.servers.' .. server).settings()
            local filetypes = require('lsp.servers.' .. server).filetypes()
            local cmd = require('lsp.servers.' .. server).cmd()
            lspconfig[server].setup {
                on_attach = M.on_attach,
                cmd = cmd,
                capabilities = capabilities,
                settings = settings,
                filetypes = filetypes,
            }
        else
            lspconfig[server].setup {
                on_attach = M.on_attach,
                capabilities = capabilities,
            }
        end
    end
    -- Manual Servers --
    lspconfig.powershell_es.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities(),
        -- bundle is at ~/repos/powershell-es
        bundle_path = vim.fn.expand('~/repos/powershell-es'),
    }
    -- Custom servers --
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
