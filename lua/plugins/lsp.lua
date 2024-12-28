return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        lazy = true,
        config = function(_, opts)
            require('lsp.lspconfig').setup(opts)
        end,
    },
    -- {
    --     'nvimtools/none-ls.nvim',
    --     lazy = true,
    --     event = 'BufRead',
    --     dependencies = {
    --         'neovim/nvim-lspconfig',
    --         'nvim-lua/plenary.nvim',
    --     },
    --     config = function()
    --         local none = require 'null-ls'
    --         local sources = {
    --             -- Python
    --             none.builtins.formatting.black,
    --             -- Lua
    --             none.builtins.formatting.stylua,
    --             -- General
    --             none.builtins.formatting.prettierd,
    --             -- Dockerfile
    --             -- none.builtins.formatting.dockerfile,
    --             -- Rust
    --             -- none.builtins.formatting.rustfmt,
    --             -- Shell
    --             none.builtins.formatting.shfmt,
    --             -- Nix
    --             none.builtins.formatting.alejandra,
    --         }
    --         none.setup {
    --             sources = sources,
    --         }
    --     end,
    -- },
    {
        enabled = false,
        dir = '/home/norpie/repos/completionist/completionist-nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'rcarriga/nvim-notify',
        },
        lazy = false,
        event = 'InsertEnter',
        opts = {
            notifications = {
                startup_connection_check = true,
            },
        },
    },
    {
        enabled = false,
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = {
                md = true,
                markdown = true,
            }
        end,
    },
    {
        enabled = true,
        'TabbyML/vim-tabby',
        lazy = false,
        config = function()
            vim.g.tabby_keybind_accept = '<TAB>'
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        init = function()
            vim.g.tabby_agent_start_command = { "npx", "tabby-agent", "--stdio" }
            vim.g.tabby_inline_completion_trigger = "auto"
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' },
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('lsp.jdtls').launch()
        end,
        keys = {
            -- nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
            {
                '<C-S-O>',
                function()
                    require('jdtls').organize_imports()
                end,
            },
        },
    },
    {
        'utilyre/barbecue.nvim',
        name = 'barbecue',
        event = 'VeryLazy',
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'SmiteshP/nvim-navbuddy',
        opts = {
            lsp = {
                auto_attach = true,
            },
        },
        keys = {
            { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
        },
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
    },
    -- {
    --     'kosayoda/nvim-lightbulb',
    --     event = 'VeryLazy',
    --     config = function()
    --         require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    --     end,
    --     dependencies = {
    --         'neovim/nvim-lspconfig'
    --     }
    -- },
    {
        'saecki/crates.nvim',
        ft = 'toml',
        config = function()
            require('crates').setup()
        end,
    },
    -- {
    --     'folke/trouble.nvim',
    --     dependencies = {
    --         'neovim/nvim-lspconfig',
    --         'nvim-tree/nvim-web-devicons',
    --     },
    --     config = function()
    --         require('trouble').setup()
    --     end,
    --     cmd = {
    --         'TroubleToggle',
    --     },
    --     keys = {
    --         { '<leader>tt', '<cmd>TroubleToggle<CR>' },
    --         { '<leader>tq', '<cmd>TroubleToggle quickfix<CR>' },
    --         { '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>' },
    --         { '<leader>td', '<cmd>TroubleToggle document_diagnostics<CR>' },
    --     },
    -- },
    -- {
    --
    --     'weilbith/nvim-code-action-menu',
    --     dependencies = {
    --         'neovim/nvim-lspconfig',
    --     },
    --     keys = {
    --         { '<leader>q', '<cmd>CodeActionMenu<CR>', desc = 'Code Action Menu' },
    --     },
    -- },
    {
        'ray-x/go.nvim',
        dependencies = { -- optional packages
            'ray-x/guihua.lua',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('go').setup {
                luasnip = true,
            }
            vim.keymap.set('n', '<leader>r', '<cmd>GoRename<CR>', { desc = 'Go Rename' })
            vim.keymap.set('n', '<leader>f', '<cmd>GoFormat<CR>', { desc = 'Go Format' })
            vim.keymap.set('n', '<leader>sw', '<cmd>GoFillSwitch<CR>', { desc = 'Go Fill Switch' })
            vim.keymap.set('n', '<leader>st', '<cmd>GoFillStruct<CR>', { desc = 'Go Fill Struct' })
            vim.keymap.set('n', '<leader>i', '<cmd>GoIfErr<CR>', { desc = 'Go If Error' })
        end,
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
        'mrcjkb/rustaceanvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        lazy = false, -- This plugin is already lazy
        -- event = 'BufRead',
        -- ft = { 'rust' },
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
                    cmd = function()
                        return { 'ra-multiplex', 'client' }
                    end,
                    standalone = false,
                    -- default_settings = {
                    --     ['rust-analyzer'] = {
                    --         check = {
                    --             overrideCommand = {
                    --                 'cargo',
                    --                 'check',
                    --                 -- '--message-format=json-diagnostic-rendered-ansi',
                    --                 -- '--fix',
                    --                 -- '--allow-dirty',
                    --             },
                    --         },
                    --     },
                    -- },
                },
            }
        end,
        -- version = '^5', -- Recommended
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        event = 'BufRead',
        config = function()
            require('mason-lspconfig').setup()
            -- vim.api.nvim_create_autocmd("FileType", {
            --     group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
            --     callback = function(t)
            --         if vim.bo[t.buf].buftype ~= "" then return end
            --         local mason_lspconfig = require("mason-lspconfig")
            --         local available_servers =
            --             mason_lspconfig.get_available_servers({ filetype = t.match })
            --         local installed_servers = mason_lspconfig.get_installed_servers()
            --         local is_available = false
            --         for _, available in ipairs(available_servers) do
            --             for _, installed in ipairs(installed_servers) do
            --                 if available == installed then return end
            --             end
            --             is_available = true
            --         end
            --         if is_available then
            --             vim.schedule(vim.cmd.LspInstall)
            --         end
            --     end,
            -- })
        end,
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup {
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            }
        end,
        cmd = {
            'Mason',
            'MasonUpdate',
            'MasonInstall',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonLog',
        },
    },
}
