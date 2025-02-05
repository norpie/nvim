return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Completion
            'saghen/blink.cmp',
            -- Rust
            --
            -- Neovim dev
            {
                'folke/lazydev.nvim',
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            -- Navbuddy
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } },
                keys = {
                    { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
                },
            }
        },

        -- example using `opts` for defining servers
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local lspconfig = require 'lspconfig'
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                config.on_attach = function(client, buffer)
                    if client.server_capabilities.documentSymbolProvider then
                        require('nvim-navic').attach(client, buffer)
                    end

                    vim.keymap.set('n', '<leader>f', function()
                        if client and client.supports_method 'textDocument/formatting' then
                            local ok, _ = pcall(vim.lsp.buf.format, { async = true })
                            if ok then
                                return
                            end
                            vim.cmd 'Neoformat'
                        end
                        -- Try to use lsp formatter first, if it fails, use neoformat
                    end, { buffer = buffer, noremap = true, silent = true, desc = 'Format' })
                    vim.keymap.set(
                        'n',
                        '<leader>q',
                        vim.lsp.buf.code_action,
                        { buffer = buffer, noremap = true, silent = true, desc = 'Code action' }
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>r',
                        vim.lsp.buf.rename,
                        { buffer = buffer, noremap = true, silent = true, desc = 'Rename' }
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>h',
                        vim.lsp.buf.hover,
                        { buffer = buffer, noremap = true, silent = true, desc = 'Show hover' }
                    )
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
                end
                lspconfig[server].setup(config)
            end
        end,
    },
    -- Format
    {
        lazy = true,
        'sbdchd/neoformat',
        cmd = 'Neoformat'
    },
    {
        'mrcjkb/rustaceanvim',
        dependencies = {
            'neovim/nvim-lspconfig',
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
}
