local M = {}

function M.lsp() return 'lua_ls' end

function M.lspconfig()
    return {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
                telemetry = { enable = false },
            },
        },
    }
end

function M.setup()
end

return M
