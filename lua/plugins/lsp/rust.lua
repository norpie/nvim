-- Rust language support
return {
    'mrcjkb/rustaceanvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        { 'saecki/crates.nvim', opts = {} }
    },
    lazy = false,
    init = function()
        vim.g.rustaceanvim = {
            -- Plugin options
            tools = {},
            -- LSP options
            server = {
                on_attach = function(_, buffer)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end)
                    vim.keymap.set('n', '<leader>q', '<cmd>RustLsp codeAction<CR>')
                    vim.keymap.set('n', '<leader>p', '<cmd>RustLsp parentModule<CR>')
                    vim.keymap.set(
                        'n',
                        'gd',
                        vim.lsp.buf.definition,
                        { buffer = buffer, noremap = true, silent = true, desc = 'Go to definition' }
                    )
                    vim.keymap.set(
                        'n',
                        'gD',
                        vim.lsp.buf.declaration,
                        { buffer = buffer, noremap = true, silent = true, desc = 'Go to declaration' }
                    )
                    vim.keymap.set('n', '<leader>oc', '<cmd>RustLsp openCargo<CR>')
                    vim.keymap.set('n', '<leader>op', '<cmd>RustLsp parentModule<CR>')
                    vim.keymap.set('n', '<leader>h', '<cmd>RustLsp hover actions<CR>')
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
                        { buffer = buffer, noremap = true, silent = true })
                end,
                standalone = false,
            },
        }
    end,
}
