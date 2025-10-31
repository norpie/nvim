-- Main LSP configuration
-- This file sets up global LSP behavior, keymaps, and capabilities

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
                -- Try to use neoformat if LSP doesn't support formatting
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

-- Export function to get capabilities (lazy-loaded)
return {
    get_capabilities = function()
        local ok, blink = pcall(require, 'blink.cmp')
        if ok then
            return blink.get_lsp_capabilities()
        end
        return vim.lsp.protocol.make_client_capabilities()
    end,
}
