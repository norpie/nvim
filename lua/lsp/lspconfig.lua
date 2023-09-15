local M = {}

function M.setup()
    local on_attach = function(client, bufnr)
        -- require("aerial").on_attach(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
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

    local servers = {
        'cssls',
        'emmet_ls',
        'html',
        'jdtls',
        'jsonls',
        'vtsls',
        'pylsp',
        'pyright',
        'texlab',
        'clangd',
        'volar',
        'vimls',
        'taplo',
        --'rust_analyzer',
        'lua_ls',
        --'sqls'
    }
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')
    for _, server in pairs(servers) do
        if vim.fn.filereadable(vim.fn.stdpath "config" .. "/lua/lsp/servers/" .. server .. ".lua") == 1 then
            local settings = require('lsp.servers.' .. server).settings()
            local filetypes = require('lsp.servers.' .. server).filetypes()
            local cmd = require('lsp.servers.' .. server).cmd()
            lspconfig[server].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = cmd,
                settings = settings,
                filetypes = filetypes
            }
        else
            lspconfig[server].setup {
                init_options = {
                    provideFormatter = true
                },
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    end
end

return M
