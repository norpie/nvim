local M = {}

function M.capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

function M.on_attach(client, bufnr)
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

function M.setup()
    local servers = {
        'cssls',
        'emmet_ls',
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
