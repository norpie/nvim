require('plugins.languages')

local navbuddy = require('nvim-navbuddy')
local actions = require("nvim-navbuddy.actions")
navbuddy.setup({
    lsp = { auto_attach = true },
    mappings = {
        ["j"] = actions.parent(),           -- Move to left panel
        ["k"] = actions.next_sibling(),     -- down
        ["l"] = actions.previous_sibling(), -- up
        [";"] = actions.children(),         -- Move to right panel
    }
})

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({ virtual_text = false })

local languages = {
    'lua_ls',
}

for _, language in ipairs(languages) do
    local ok, config = pcall(require, 'languages.' .. language)
    local lsp = config.lsp()
    if ok then
        vim.lsp.config(lsp, config.lspconfig())
    end
    vim.lsp.enable(lsp)
end

-- in lsp context
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspAutocmd', {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        vim.api.nvim_clear_autocmds({ group = 'LspAutocmd', buffer = args.buf })

        -- nav keymaps
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = args.buf, desc = 'Go to type definition' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf, desc = 'Go to declaration' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = args.buf, desc = 'Go to implementation' })
        -- info
        vim.keymap.set('n', 'H', vim.lsp.buf.hover, { buffer = args.buf, desc = 'Hover' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = args.buf, desc = 'References' })
        -- plugins
        vim.keymap.set('n', '<leader>n', '<cmd>Navbuddy<cr>', { buffer = args.buf, desc = 'Navbuddy' })
        -- actions
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf, desc = 'Rename' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'Code action' })
        vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { buffer = args.buf, desc = 'Workspace symbol' })
        vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { buffer = args.buf, desc = 'Document symbol' })
        -- diagnostic keymaps
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { buffer = args.buf, desc = 'Open diagnostic float' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = args.buf, desc = 'Go to previous diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = args.buf, desc = 'Go to next diagnostic' })
        -- more complex
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ bufnr = args.buf })
        end, { buffer = args.buf, desc = 'Format' })

        -- Format on save
        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = 'LspAutocmd',
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf })
                end,
            })
        end
    end,
})
