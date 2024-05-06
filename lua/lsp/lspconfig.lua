local M = {}

function M.setup_keys(buffer)
    local opts = { buffer = buffer, noremap = true, silent = true }
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --  keys = {
    --         {
    --             '<leader>f',
    --             function()
    --                 vim.lsp.buf.format()
    --             end,
    --             desc = 'lsp format',
    --         },
    --         {
    --             '<leader>h',
    --             function()
    --                 vim.lsp.buf.hover()
    --             end,
    --             desc = 'lsp hover',
    --         },
    --         {
    --             'gd',
    --             function()
    --                 vim.lsp.buf.definition()
    --             end,
    --             desc = 'lsp definition',
    --         },
    --         {
    --             'gD',
    --             function()
    --                 vim.lsp.buf.declaration()
    --             end,
    --             desc = 'lsp declaration',
    --         },
    --     },
end

function M.capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

function M.on_attach(client, buffer)
    -- If not null-ls, then disable formatting
    if client.name ~= 'null-ls' then
        client.server_capabilities.documentFormattingProvider = false
    end
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, buffer)
    end
    M.setup_keys(buffer)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- disable virtual text
            virtual_text = true,

            -- show signs
            signs = true,

            -- show_diagnostic_autocmds = { "BufWritePost" },
            show_diagnostic_autocmds = { "InsertLeave", "BufWritePost" },
        }
    )
end

function M.setup()
    local servers = {
        'cssls',
        'emmet_ls',
        'bashls',
        'html',
        'jsonls',
        'vtsls',
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
    local lspconfig = require('lspconfig')
    for _, server in pairs(servers) do
        if vim.fn.filereadable(vim.fn.stdpath "config" .. "/lua/lsp/servers/" .. server .. ".lua") == 1 then
            local settings = require('lsp.servers.' .. server).settings()
            local filetypes = require('lsp.servers.' .. server).filetypes()
            local cmd = require('lsp.servers.' .. server).cmd()
            lspconfig[server].setup {
                on_attach = M.on_attach,
                capabilities = M.capabilities(),
                cmd = cmd,
                settings = settings,
                filetypes = filetypes
            }
        else
            lspconfig[server].setup {
                init_options = {
                    provideFormatter = true
                },
                on_attach = M.on_attach,
                capabilities = M.capabilities(),
            }
        end
    end
end

return M
