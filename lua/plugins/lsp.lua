return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        keys = {
            { '<leader>f', function() vim.lsp.buf.format({ async = true }) end, desc = 'lsp format' },
            { '<leader>h', function() vim.lsp.buf.hover() end },
            { 'gd',        function() vim.lsp.buf.definition() end },
            { 'gD',        function() vim.lsp.buf.declaration() end },
        },
        config = function()
            require('lsp').setup()
        end
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        event = 'VeryLazy',
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        'SmiteshP/nvim-navbuddy',
        opts = {
            lsp = {
                auto_attach = true
            }
        },
        keys = {
            { '<leader>n', '<cmd>Navbuddy<CR>' }
        },
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim'
        }
    },
    {
        'kosayoda/nvim-lightbulb',
        event = 'VeryLazy',
        config = function()
            require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
        end,
        dependencies = {
            'neovim/nvim-lspconfig'
        }
    },
    {
        'saecki/crates.nvim',
        ft = 'toml',
        config = function()
            require('crates').setup()
        end
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('trouble').setup()
        end,
        cmd = {
            'TroubleToggle'
        },
        keys = {
            { '<leader>tt', '<cmd>TroubleToggle<CR>' },
            { '<leader>tq', '<cmd>TroubleToggle quickfix<CR>' },
            { '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>' },
            { '<leader>td', '<cmd>TroubleToggle document_diagnostics<CR>' }
        },
    },
    {

        'weilbith/nvim-code-action-menu',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        keys = {
            { '<leader>q', '<cmd>CodeActionMenu<CR>' }
        }
    },
    {

        'simrat39/rust-tools.nvim',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        event = { "BufReadPost *.rs" },
        config = function()
            local rt = require("rust-tools")
            local opts = {
                server = {
                    cmd = { "ra-multiplex", "client" },
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
                        vim.keymap.set("n", "<leader>q", rt.code_action_group.code_action_group, { buffer = bufnr })
                        vim.keymap.set("n", "<leader>oc", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
                        vim.keymap.set("n", "<leader>op", rt.parent_module.parent_module, { buffer = bufnr })
                    end,
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                                extraArgs = { "--all", "--", "-W", "clippy::all" },
                            },
                            --procMacro = {
                            --    enable = true
                            --},
                        }
                    }
                },
            }
            rt.setup(opts)
        end,
    },
    {
        'simrat39/symbols-outline.nvim',
        keys = {
            { '<leader>os', '<cmd>SymbolsOutline<CR>' }
        },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('symbols-outline').setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        --event = 'VeryLazy',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require("mason-lspconfig").setup()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
                callback = function(t)
                    if vim.bo[t.buf].buftype ~= "" then return end
                    local mason_lspconfig = require("mason-lspconfig")
                    local available_servers =
                        mason_lspconfig.get_available_servers({ filetype = t.match })
                    local installed_servers = mason_lspconfig.get_installed_servers()
                    local is_available = false
                    for _, available in ipairs(available_servers) do
                        for _, installed in ipairs(installed_servers) do
                            if available == installed then return end
                        end
                        is_available = true
                    end
                    if is_available then
                        vim.schedule(vim.cmd.LspInstall)
                    end
                end,
            })
        end

    },
    {
        'williamboman/mason.nvim',
        dependencies = { 'neovim/nvim-lspconfig' },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
        cmd = {
            "Mason",
            "MasonUpdate",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        }
    }
}
