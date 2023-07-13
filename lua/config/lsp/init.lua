local M = {}

function M.setup()
    -- Own
    require('config.lsp.mason').setup()
    require('config.lsp.lspconfig').setup()
    -- Language Specific
    vim.cmd([[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require('config.lsp.jdtls').launch()
    augroup end
    ]])

    -- General
    require('trouble').setup()
    --require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    require('symbols-outline').setup()
    require('crates').setup()
    --
    --local saga = require("lspsaga")
    --local sage_settings = {}

    --saga.init_lsp_saga(sage_settings)
end

return M
