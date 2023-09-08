local M = {}

function M.setup()
    -- Own
    -- require('config.lsp.mason').setup()
    require('config.lsp.lspconfig').setup()
    -- Language Specific
    --vim.cmd([[
    --augroup jdtls_lsp
    --    autocmd!
    --    autocmd FileType java lua require('config.lsp.jdtls').launch()
    --augroup end
    --]])

    -- General
end

return M
