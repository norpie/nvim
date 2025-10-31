-- LSP Configuration
-- Sets up LSP keymaps, capabilities, and all language servers using Neovim 0.11 native APIs

-- Helper function to get LSP capabilities (includes blink.cmp)
local function get_capabilities()
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
        return blink.get_lsp_capabilities()
    end
    return vim.lsp.protocol.make_client_capabilities()
end

-- LspAttach autocmd for keymaps and per-buffer configuration
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local buffer = args.buf

        -- Attach nvim-navic for document symbols if supported
        if client and client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, buffer)
        end

        -- Keymaps
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buffer, noremap = true, silent = true, desc = desc })
        end

        -- Format
        map('n', '<leader>f', function()
            if client and client.supports_method('textDocument/formatting') then
                local ok, _ = pcall(vim.lsp.buf.format, { async = true })
                if ok then
                    return
                end
                vim.cmd('Neoformat')
            else
                vim.cmd('Neoformat')
            end
        end, 'Format')

        -- Code action
        map('n', '<leader>q', vim.lsp.buf.code_action, 'Code action')

        -- Rename
        map('n', '<leader>r', vim.lsp.buf.rename, 'Rename')

        -- Hover
        map('n', '<leader>h', vim.lsp.buf.hover, 'Show hover')

        -- Go to definition
        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')

        -- Go to declaration
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    end,
})

-- Configure and enable LSP servers
local servers = {
    'lua_ls',
    'cssls',
    'emmet_ls',
    'bashls',
    'html',
    'jsonls',
    'tailwindcss',
    'sqlls',
    'texlab',
    'svelte',
    'taplo',
    'vimls',
    'nil_ls',
    'pyright',
}

local capabilities = get_capabilities()

-- Load and configure each server
for _, server in ipairs(servers) do
    local ok, server_config = pcall(require, 'lsp.' .. server)

    if ok then
        -- Add capabilities
        server_config.capabilities = capabilities

        -- Configure the server using native API (correct syntax: vim.lsp.config['server'] = config)
        vim.lsp.config[server] = server_config
    else
        vim.notify('Failed to load LSP config for ' .. server, vim.log.levels.WARN)
    end
end

-- Enable all configured servers
vim.lsp.enable(servers)

-- Load custom server (SurrealQL)
require('lsp.custom.surrealql')
