require('plugins.lspconfig')

local lsps = {
    'lua_ls',
    'bashls',
}

for _, lsp in ipairs(lsps) do
    local ok, config = pcall(require, 'lsp.' .. lsp)
    if ok then
        vim.lsp.config(lsp, config)
    end
    vim.lsp.enable(lsp)
end

-- formatting
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspFormatting', {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = 'LspFormatting', buffer = args.buf })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = 'LspFormatting',
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf })
                end,
            })
        end
    end,
})
