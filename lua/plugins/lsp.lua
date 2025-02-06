return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Completion
            'saghen/blink.cmp',
            -- Auto configuring LSP and installing servers
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- Typescript
            { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
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
                lua_ls = {},
                cssls = {},
                emmet_ls = {},
                bashls = {},
                html = {},
                jsonls = {},
                ts_ls = {},
                tailwindcss = {},
                sqlls = {},
                texlab = {},
                svelte = {},
                taplo = {},
                vimls = {},
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            require('mason').setup()
            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup {
                automatic_installation = true,
                ensure_installed = { "pyright" }
            }
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
    { -- Format
        lazy = true,
        'sbdchd/neoformat',
        cmd = 'Neoformat'
    },
    {                    -- Go
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        -- if you need to install/update all binaries
        build = ':lua require("go.install").update_all_sync()'
    },
    { -- PHP
        "gbprod/phpactor.nvim",
        ft = "php",
        build = function()
            require("phpactor.handler.update")()
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
            {
                'ta-tikoma/php.easy.nvim',
                config = true,
                keys = {
                    { '-#',   '<CMD>PHPEasyAttribute<CR>',         ft = 'php' },
                    { '-b',   '<CMD>PHPEasyDocBlock<CR>',          ft = 'php' },
                    { '-r',   '<CMD>PHPEasyReplica<CR>',           ft = 'php' },
                    { '-c',   '<CMD>PHPEasyCopy<CR>',              ft = 'php' },
                    { '-d',   '<CMD>PHPEasyDelete<CR>',            ft = 'php' },
                    { '-uu',  '<CMD>PHPEasyRemoveUnusedUses<CR>',  ft = 'php' },
                    { '-e',   '<CMD>PHPEasyExtends<CR>',           ft = 'php' },
                    { '-i',   '<CMD>PHPEasyImplements<CR>',        ft = 'php' },
                    { '--i',  '<CMD>PHPEasyInitInterface<CR>',     ft = 'php' },
                    { '--c',  '<CMD>PHPEasyInitClass<CR>',         ft = 'php' },
                    { '--ac', '<CMD>PHPEasyInitAbstractClass<CR>', ft = 'php' },
                    { '--t',  '<CMD>PHPEasyInitTrait<CR>',         ft = 'php' },
                    { '--e',  '<CMD>PHPEasyInitEnum<CR>',          ft = 'php' },
                    { '-c',   '<CMD>PHPEasyAppendConstant<CR>',    ft = 'php', mode = { 'n', 'v' } },
                    { '-p',   '<CMD>PHPEasyAppendProperty<CR>',    ft = 'php', mode = { 'n', 'v' } },
                    { '-m',   '<CMD>PHPEasyAppendMethod<CR>',      ft = 'php', mode = { 'n', 'v' } },
                    { '__',   '<CMD>PHPEasyAppendConstruct<CR>',   ft = 'php' },
                    { '_i',   '<CMD>PHPEasyAppendInvoke<CR>',      ft = 'php' },
                    { '-a',   '<CMD>PHPEasyAppendArgument<CR>',    ft = 'php' },
                }
            },
        },
        opts = {},
    },
    { -- Rust
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
